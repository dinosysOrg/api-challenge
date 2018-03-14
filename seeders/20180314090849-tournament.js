"use strict";
const moment = require("moment");
const datetimeFormat = "YYYY-MM-DD HH:mm:ss";

module.exports = {
  up: async (queryInterface, Sequelize) => {
    const created_at = moment().format(datetimeFormat);
    await queryInterface.bulkInsert("ds_group", [{ name: "A1", created_at }]);
    await queryInterface.bulkInsert("ds_venue", [
      { name: "Legend", created_at }
    ]);
    await queryInterface.bulkInsert("ds_player", [
      { name: "Mark Zuckerberg", created_at }
    ]);
    await queryInterface.bulkInsert("ds_player", [
      { name: "Diane Greene", created_at }
    ]);

    await queryInterface.bulkInsert("ds_match", [
      {
        group_id: 1,
        venue_id: 1,
        player_1_id: 1,
        player_2_id: 1,
        code: "C1-1-2",
        start_at: moment("2017-02-16 14:00:00").format(datetimeFormat),
        score: "Diane Greene gave up",
        created_at
      }
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete("ds_group", null, {});
    await queryInterface.bulkDelete("ds_player", null, {});
    await queryInterface.bulkDelete("ds_match", null, {});
    return true;
  }
};
