const gaveUpPattern = /([ \w+]+) gave up/;

const POINT_WIN = 3;
const POINT_LOST = 0;
const POINT_DRAWN = 1;

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

  return {
    [player1]: resolvePoint(Number(player1Score), Number(player2Score)),
    [player2]: resolvePoint(Number(player2Score), Number(player1Score))
  };
};

const resolveGaveUpPoint = (gaveUpPlayer, comparePlayer) =>
  gaveUpPlayer === comparePlayer ? resolvePoint(0, 1) : resolvePoint(1, 0);

const resolvePoint = (playerScore, opponentScore) => {
  if (playerScore > opponentScore) return POINT_WIN;
  if (playerScore < opponentScore) return POINT_LOST;
  return POINT_DRAWN;
};

module.exports.POINT_WIN = POINT_WIN;
module.exports.POINT_LOST = POINT_LOST;
module.exports.POINT_DRAWN = POINT_DRAWN;
