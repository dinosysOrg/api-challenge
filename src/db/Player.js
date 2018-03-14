module.exports = (sequelize, DataTypes) => {
  return sequelize.define(
    "Player",
    {
      id: {
        type: DataTypes.BIGINT,
        primaryKey: true,
        autoIncrement: true
      },
      name: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
        validate: {
          notEmpty: true
        }
      }
    },
    {
      underscored: true,
      freezeTableName: true,
      timestamps: true,
      tableName: "ds_player"
    }
  );
};
