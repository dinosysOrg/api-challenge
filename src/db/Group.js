module.exports = (sequelize, DataTypes) => {
  return sequelize.define(
    "Group",
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
          isAlphanumeric: true,
          notEmpty: true
        }
      }
    },
    {
      underscored: true,
      freezeTableName: true,
      timestamps: true,
      tableName: "ds_group"
    }
  );
};
