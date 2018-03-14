const gaveUpPattern = /([ \w+]+) gave up/;

const POINT_WIN = 3;
const POINT_LOST = 0;
const POINT_DRAW = 1;

module.exports = ({ player1, player2, score }) => {
  // Case a player gave up
  const matched = score.match(gaveUpPattern);
  if (matched) {
    return {
      [player1]: resolveGaveUpPoint(matched[1], player1),
      [player2]: resolveGaveUpPoint(matched[1], player2)
    };
  }

  let [player1Score, player2Score] = score.split("-");
  return resolvePoint(Number(player1Score), Number(player2Score));
};

const resolveGaveUpPoint = (gaveUpPlayer, comparePlayer) =>
  gaveUpPlayer === comparePlayer ? resolvePoint(0, 1) : resolvePoint(1, 0);

const resolvePoint = (playerScore, opponentScore) => {
  if (playerScore > opponentScore) return POINT_WIN;
  if (playerScore < opponentScore) return POINT_LOST;
  return POINT_DRAW;
};

module.exports.POINT_WIN = POINT_WIN;
module.exports.POINT_LOST = POINT_LOST;
module.exports.POINT_DRAW = POINT_DRAW;
