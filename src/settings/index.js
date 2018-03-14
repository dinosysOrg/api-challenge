const path = require("path");

module.exports = {
  debug: process.env.NODE_ENV !== "production",
  port: process.env.PORT || 9999,
  allowHosts: process.env.ALLOW_HOSTS
    ? process.env.ALLOW_HOSTS.split(",").map(org => org.trim())
    : [],
  uploadFolder:
    process.env.UPLOAD_FOLDER || path.resolve(__dirname, "../public/upload"),
  allowMinetypes: process.env.ALLOW_FILE
    ? process.env.ALLOW_FILE.split(",").map(org => org.trim())
    : ["text/csv"],
  uploadLimits: {
    fields: Number(process.env.UPLOAD_MAX_FIELD) || 17,
    files: Number(process.env.UPLOAD_MAX_FILE) || 17,
    fileSize: Number(process.env.UPLOAD_MAX_SIZE || 100) * 1048576,
    parts: Number(process.env.UPLOAD_MAX_PART) || 17
  },
  queryLimit: Number(process.env.QUERY_LIMIT) || 20
};
