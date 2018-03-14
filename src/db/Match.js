module.exports = (sequelize, DataTypes) => {
  const Model = sequelize.define(
    "Match",
    {
      id: {
        type: DataTypes.BIGINT,
        primaryKey: true,
        autoIncrement: true
      },
      player_1_id: {
        type: DataTypes.BIGINT(11),
        allowNull: false,
        validate: {
          isInt: true,
          notEmpty: true
        }
      },
      player_2_id: {
        type: DataTypes.BIGINT(11),
        allowNull: false,
        validate: {
          isInt: true,
          notEmpty: true
        }
      },
      code: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
        validate: {
          notEmpty: true
        }
      },
      start_at: {
        type: DataTypes.DATE(6),
        allowNull: false,
        validate: {
          notEmpty: true
        }
      },
      score: {
        type: DataTypes.STRING,
        allowNull: false,
        validate: {
          notEmpty: true
        }
      }
    },
    {
      underscored: true,
      freezeTableName: true,
      timestamps: true,
      tableName: "ds_match"
    }
  );

  Model.associate = ({ Match, Player, Group, Venue, Statistics }) => {
    Match.belongsTo(Player, { as: "Player1", foreignKey: "player_1_id" });
    Match.belongsTo(Player, { as: "Player2", foreignKey: "player_2_id" });
    Match.belongsTo(Group);
    Match.belongsTo(Venue);

    Match.hasOne(Statistics);
  };

  return Model;
};
