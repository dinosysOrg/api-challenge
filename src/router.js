const { Router } = require("express");

const { name, version, description, author, license } = require("../package");

// Controllers
const uploadController = require("./controllers/upload");
const matchController = require("./controllers/match");
const statisticsController = require("./controllers/statistics");

// Init router
const router = Router();

// Root
router.get("/", (req, res) => {
  res.json({ name, version, description, author, license });
});

// Upload csv files
router.post(
  "/upload",
  uploadController.multer().array("files"),
  uploadController.parse,
  uploadController.save,
  (req, res) => res.json(res.parsed)
);

// Query matches
router.get("/matches", matchController.findAll, (req, res) =>
  res.json(res.matches)
);

// Query statistic
router.get("/statistics", statisticsController.findAll, (req, res) =>
  res.json(res.statistics)
);

// Export router
module.exports = router;
