  setting = require '../setting'
  request = require 'request'
  Book = require '../lib/book'
  oauth = require '../lib/oauth'
  express = require 'express'
  bodyParser = require 'body-parser'
  crypto = require 'crypto'
  models = require '../model'
  router = express.Router()

  router.get '/v1/books/list',(req, res) ->
    book = new Book req.query
    book.search (err,data) ->
      if not err?
        res.json data.books
  #
  # register
  #

  router.post '/v1/register', bodyParser(), (req, res) ->
    sha1 = crypto.createHash 'sha1'
    body = req.body
    response =
      msg: ''
      success: false

    if body.loginName == '' or body.password == ''
      response = 
        msg: 'INVALID_USER'
        success: false
      res.json response
    else if body.password.length < 6
      response = 
        msg: 'PASSWORD_LENGTH'
        success: false
      res.json response
    else if body.loginName.length < 4
      response = 
        msg:'LOGINNAME_LENGTH'
        success: false
      res.json response
    else
      checkUserExist body, (bool) ->
        if !bool
          user =
            loginName: body.loginName
            password: sha1.update(body.password).digest 'hex'
            createdAt: new Date() - 0
          models.User.create(user)
            .then (user)->
             response = 
              msg:''
              success: true
             res.json response
        else
          response =
            msg: 'USER_EXIST'
            success: false
          res.json response

  # 
  # book api
  #

  router.get '/v1/book/detail/:isbn',(req,res) ->
    book = new Book req.params
    book.detail (err,data) ->
      if not err?
        res.json data

  router.get '/oauth/douban',(req,res)->
    res.redirect 'https://www.douban.com/service/auth2/auth?response_type=
    code&client_id='
    +setting.douban_auth.client_id+
    '&redirect_uri='+setting.douban_auth.dev_host+
    'user/douban/callback'

  module.exports = router


  checkUserExist = (user, next)->
    models.User.find(
      where:
        loginName: user.loginName
    )
      .then (u)->
        if u && u.get('loginName')
          next true
        else
          next false
