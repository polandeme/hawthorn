
###
Module dependencies.
###
express = require("express")
http = require("http")
path = require("path")
favicon = require('static-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')
api = require('./controller/api')
index = require('./controller/index')
app = express()

# all environments
app.set "port", process.env.PORT or 4000

app.use(favicon())
app.use(logger('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded())
app.use(cookieParser())

app.use('/',index)
app.use('/api',api)

app.listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")


