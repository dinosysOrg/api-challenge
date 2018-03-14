module.exports = (sequelize, DataTypes) => {
  const Model = sequelize.define(
    "Statistic",
    {
      id: {
        type: DataTypes.BIGINT,
        primaryKey: true,
        autoIncrement: true
      },
      point: {
        type: DataTypes.INTEGER,
        allowNull: false,
        validate: {
          isNumeric: true
        }
      }
    },
    {
      underscored: true,
      freezeTableName: true,
      timestamps: false,
      tableName: "ds_group",
      indexes: [
        {
          unique: true,
          fields: ["match_id", "player_id"]
        }
      ]
    }
  );

  Model.associate = ({ Statistic, Player, Match }) => {
    Statistic.belongsTo(Player);
    Statistic.belongsTo(Match);
  };

  return Model;
};
