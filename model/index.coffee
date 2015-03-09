setting = require('../setting')
Sequelize = require('sequelize')
fs = require('fs')
path = require('path')
db = {}

sequelize = new Sequelize setting.mysql.database,
  setting.mysql.user,
  setting.mysql.password,

fs.
  readdirSync(__dirname)
  .filter (file) ->
    return (file.indexOf('.') != 0) && (file != 'index.coffee');
  .forEach (file) ->
    model = sequelize['import'](path.join(__dirname,file))
    db[model.name] = model

Object.keys(db).forEach (modelName)->
  db[modelName].associate(db) if 'associate' in db[modelName]

db.sequelize = sequelize

module.exports = db
