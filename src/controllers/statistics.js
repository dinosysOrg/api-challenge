const Sequelize = require("sequelize");

const calculatePoint = require("../utils/calculatePoint");
const { Op } = Sequelize;

module.exports.findAll = async (req, res, next) => {
  const { playerName } = req.query;
  const { Player, Statistics, Match } = req.app.get("db");

  // Make sure request player is exist
  const player = await Player.find({ where: { name: playerName } });
  if (!player) {
    // Player is not found
    return res
      .status(404)
      .json({ message: `Player ${playerName} is not found.` });
  }

  // Check processed id
  const processedIds = await Match.findAll({
    attributes: ["id"],
    where: {
      [Op.or]: [{ player_1_id: player.id }, { player_2_id: player.id }]
    },
    include: [
      {
        model: Statistics,
        where: {
          match_id: Sequelize.col("Match.id")
        },
        attributes: []
      }
    ]
  });
  // Query unprocess matches
  const matches = await Match.findAndCountAll({
    where: {
      [Op.or]: [{ player_1_id: player.id }, { player_2_id: player.id }],
      id: { [Op.notIn]: processedIds.map(({ id }) => id) }
    },
    include: [
      {
        model: Player,
        as: "Player1",
        where: { id: Sequelize.col("Match.player_1_id") },
        attributes: ["name"]
      },
      {
        model: Player,
        as: "Player2",
        where: { id: Sequelize.col("Match.player_2_id") },
        attributes: ["name"]
      }
    ]
  });

  let failedToStat = [];
  // Process all unprocess match
  if (matches.count) {
    const processQueue = [];
    for (let i = 0; i < matches.count; i++) {
      const match = matches.rows[i];
      statisticAttributes = {
        match_id: match.id,
        player_id: player.id,
        point: calculatePoint({
          player1: match.Player1.name,
          player2: match.Player2.name,
          score: match.score
        })[player.name]
      };

      processQueue.push(
        Statistics.create(statisticAttributes).catch(() => {
          failedToStat.push(match.id);
        })
      );
    }

    await Promise.all(processQueue);
  }

  // Query statistics
  const statisticsQueue = [];

  // Points
  statisticsQueue.push(
    Statistics.find({
      where: { player_id: player.id },
      attributes: [[Sequelize.fn("SUM", Sequelize.col("point")), "points"]]
    })
  );
  // Won matches
  statisticsQueue.push(
    Statistics.find({
      where: { player_id: player.id, point: calculatePoint.POINT_WIN },
      attributes: [[Sequelize.fn("COUNT", Sequelize.col("id")), "won_matches"]]
    })
  );
  // Lost matches
  statisticsQueue.push(
    Statistics.find({
      where: { player_id: player.id, point: calculatePoint.POINT_LOST },
      attributes: [[Sequelize.fn("COUNT", Sequelize.col("id")), "lost_matches"]]
    })
  );
  // Lost matches
  statisticsQueue.push(
    Statistics.find({
      where: { player_id: player.id, point: calculatePoint.POINT_DRAWN },
      attributes: [
        [Sequelize.fn("COUNT", Sequelize.col("id")), "drawn_matches"]
      ]
    })
  );

  const stats = (await Promise.all(statisticsQueue)).reduce(
    (stats, stat) => Object.assign(stats, stat.get({ plain: true })),
    {}
  );
  return res.json({ data: Object.assign({ failedToStat }, stats) });

  return next();
};
