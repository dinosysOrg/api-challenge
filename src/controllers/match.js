const Sequelize = require("sequelize");
const { Op } = Sequelize;

const { queryLimit } = require("../settings");

module.exports.findAll = async (req, res, next) => {
  const { code, player1Name, player2Name } = req.query;
  const { Match, Player } = req.app.get("db");

  let sqlQuery = {
    where: {},
    offset: 0,
    limit: queryLimit,
    include: [],
    attributes: ["id", "code", "start_at", "score", "created_at", "updated_at"]
  };
  if (code) {
    sqlQuery.where.code = {
      [Op.like]: `%${code}%`
    };
  }

  // Query for player 1
  let player1Where = { id: Sequelize.col("Match.player_1_id") };
  if (player1Name) player1Where.name = { [Op.like]: `%${player1Name}%` };
  sqlQuery.include.push({
    model: Player,
    as: "Player1",
    where: player1Where,
    attributes: ["name"]
  });

  // Query for player 2
  let player2Where = { id: Sequelize.col("Match.player_2_id") };
  if (player2Name) player2Where.name = { [Op.like]: `%${player2Name}%` };
  sqlQuery.include.push({
    model: Player,
    as: "Player2",
    where: player2Where,
    attributes: ["name"]
  });

  const { rows, count } = await Match.findAndCountAll(sqlQuery);
  res.matches = { data: rows, total: count };
  return next();
};
