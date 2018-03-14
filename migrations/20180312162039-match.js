"use strict";

const tableName = "ds_match";
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable(tableName, {
      id: {
        type: Sequelize.BIGINT,
        primaryKey: true,
        autoIncrement: true
      },
      group_id: {
        type: Sequelize.BIGINT(11),
        allowNull: false,
      },
      venue_id: {
        type: Sequelize.BIGINT(11),
        allowNull: false,
      },
      player_1_id: {
        type: Sequelize.BIGINT(11),
        allowNull: false,
      },
      player_2_id: {
        type: Sequelize.BIGINT(11),
        allowNull: false,
      },
      code: {
        type: Sequelize.STRING,
        allowNull: false,
        unique: true
      },
      start_at: {
        type: Sequelize.DATE,
        allowNull: false,
      },
      score: {
        type: Sequelize.STRING,
        allowNull: false,
      },
      created_at: {
        type: Sequelize.DATE,
        allowNull: false,
      },
      updated_at: {
        type: Sequelize.DATE
      }
    });
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.dropTable(tableName);
  }
};
