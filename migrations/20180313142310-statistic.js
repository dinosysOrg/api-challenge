"use strict";

const tableName = "ds_statistic";
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable(tableName, {
      id: {
        type: Sequelize.BIGINT,
        primaryKey: true,
        autoIncrement: true
      },
      match_id: {
        type: Sequelize.BIGINT(11),
        allowNull: false
      },
      player_id: {
        type: Sequelize.BIGINT(11),
        allowNull: false
      },
      point: {
        type: Sequelize.INTEGER,
        allowNull: false
      }
    });
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.dropTable(tableName);
  }
};
