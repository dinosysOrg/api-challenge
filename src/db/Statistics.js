module.exports = (sequelize, DataTypes) => {
  const Model = sequelize.define(
    "Statistics",
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
      tableName: "ds_statistics",
      indexes: [
        {
          unique: true,
          fields: ["match_id", "player_id"]
        }
      ]
    }
  );

  Model.associate = ({ Statistics, Player, Match }) => {
    Statistics.belongsTo(Player);
    Statistics.belongsTo(Match);
  };

  return Model;
};
