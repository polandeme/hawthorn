module.exports = (sequelize, DataTypes) ->
  User = sequelize.define 'User',
    loginName: DataTypes.STRING
    password: DataTypes.STRING
   ,
     classMethods:
       associate: (models) ->
         User.hasMany models
  return User
            
    
