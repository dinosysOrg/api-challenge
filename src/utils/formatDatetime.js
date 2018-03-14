const moment = require("moment");

module.exports = (date, time, pattern = "YYYY-MM-DD HH:mm:ss") => {
  // Should check it is valid date format
  date = date
    .split("/")
    .reverse()
    .join("-");

  const datetime = moment(`${date} ${time}`);
  if (!datetime.isValid()) return "";

  return datetime.format(pattern);
};
