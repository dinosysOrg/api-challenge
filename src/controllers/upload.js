const multer = require("multer");
const { isEmpty, isNumber, isNaN, flatten } = require("lodash");
const csvtojson = require("csvtojson");

const { uploadFolder, allowMinetypes, uploadLimits } = require("../settings");
const formatDatetime = require("../utils/formatDatetime");

// Upload files by multer
module.exports.multer = () => {
  // Define storage
  const storage = multer.diskStorage({
    destination(req, file, cb) {
      cb(null, uploadFolder);
    },
    filename(req, { originalname }, cb) {
      cb(null, `${Date.now()}-${originalname}`);
    }
  });
  // Defined file filter
  const fileFilter = (req, { mimetype }, cb) =>
    cb(null, Boolean(allowMinetypes.indexOf(mimetype) > -1));

  return multer({ storage, fileFilter, limits: uploadLimits });
};

// Parse uploaded files
module.exports.parse = async (req, res, next) => {
  try {
    // If the upload has failed
    if (isEmpty(req.files)) return next(new Error("The upload has failed."));

    const queue = [];
    const numberOfFiles = req.files.length;
    for (let i = 0; i < numberOfFiles; i++) {
      const { path: csvPath } = req.files[i];

      // Push promise to queue
      queue.push(csvReader(csvPath));
    }

    const parsedRows = flatten(await Promise.all(queue));
    res.parsedRows = parsedRows;

    return next();
  } catch (error) {
    return next(error);
  }
};

// Save data from uploaded files
module.exports.save = async (req, res, next) => {
  try {
    let success;
    let failed = [];
    const { Player, Match, Group, Venue } = req.app.get("db");

    const totalRows = res.parsedRows.length;
    const queue = [];

    for (let i = 0; i < totalRows; i++) {
      const currentRow = res.parsedRows[i];
      const matchCode = currentRow["match code"];
      // Prepare data to create match
      const matchAttributes = {
        group_id: (await resolveGroup(currentRow.group, Group)).id,
        venue_id: (await resolveVenue(currentRow.group, Venue)).id,
        player_1_id: (await resolvePlyer(currentRow["player 1"], Player)).id,
        player_2_id: (await resolvePlyer(currentRow["player 2"], Player)).id,
        code: matchCode,
        start_at: formatDatetime(currentRow.date, currentRow.time),
        score: currentRow.score
      };
      // Push the promise to queue
      queue.push(
        resolveMatch(matchAttributes, Match).catch((error) => {
          console.log(error)
          failed.push(matchCode);
        })
      );
    }
    // If error was occured, null will be return
    // Just filter to return it
    success = (await Promise.all(queue)).filter(savedMatch => !!savedMatch);

    // Store parsed and saved data
    res.parsed = {
      data: { success, failed },
      total: res.parsedRows.length
    };

    return next();
  } catch (error) {
    return next(error);
  }
};

// Read and parse csv file to json
const csvReader = csvPath =>
  new Promise((resolve, reject) => {
    let rows = [];
    csvtojson()
      .fromFile(csvPath)
      .on("json", ({ id, ...match }) => {
        const parseId = parseInt(id, 10);
        // Don't care about empty data
        if (isEmpty(match) || !isNumber(parseId) || isNaN(parseId)) {
          return;
        }

        rows.push(match);
      })
      .on("done", error => {
        // Reject promise if that promise have error
        if (error) return reject(error);
        // Resolve parsed data
        return resolve(rows);
      })
      .on("error", reject);
  });

// Return exist group or create the new one
const resolveGroup = async (group, Group) => {
  const existEntity = await Group.find({ where: { name: group } });
  if (existEntity) return existEntity;
  return await Group.create({ name: group });
};

// Return exist venue or create the new one
const resolveVenue = async (venue, Venue) => {
  const existEntity = await Venue.find({ where: { name: venue } });
  if (existEntity) return existEntity;
  return await Venue.create({ name: venue });
};

// Return exist player or create the new one
const resolvePlyer = async (player, Player) => {
  const existEntity = await Player.find({ where: { name: player } });
  if (existEntity) return existEntity;
  return await Player.create({ name: player });
};

const resolveMatch = async (match, Match) => {
  const existEntity = await Match.find({ where: { code: match.code } });
  if (existEntity) return existEntity;
  return await Match.create(match);
};
