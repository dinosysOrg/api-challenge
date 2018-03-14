const express = require("express");
const bodyParser = require("body-parser");
const methodOverride = require("method-override");
const cors = require("cors");

const { debug, port, allowHosts } = require("./settings");
const router = require("./router");
const db = require("./db");

// Init app
const app = express();
// Settings
app.set("port", port);
app.set("db", db);
// Midleware
app.use(methodOverride());
app.use(
  cors({
    origin: allowHosts,
    optionsSuccessStatus: 200,
    preflightContinue: true
  })
);
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Routes
app.use(router);

// Error handler
app.use(({ message, stack }, req, res, next) => {
  const payload = debug
    ? { message, stack }
    : { message: "An error encountered while processing your images" };

  return res.status(500).json(payload);
});

// Export app
module.exports = app;
