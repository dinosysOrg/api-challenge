const { Router } = require("express");

const { name, version, description, author, license } = require("../package");

// Controllers
const uploadController = require("./controllers/upload");
const matchController = require("./controllers/match");

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

router.get("/matches", matchController.findAll, (req, res) =>
  res.json(res.matches)
);

// Export router
module.exports = router;
