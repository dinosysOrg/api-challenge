const app = require("../src");

const port = app.get("port");
const db = app.get("db");

db.sequelize
  .authenticate()
  .then(() => {
    app.listen(port, () => console.log(`App is running on port ${port}`));
  })
  .catch(err => {
    console.error("Unable to connect to the database:", err);
  });
