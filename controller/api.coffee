  setting = require '../setting'
  request = require 'request'
  Book = require '../lib/book'
  oauth = require '../lib/oauth'
  express = require('express')
  router = express.Router()

  router.get '/',(req,res) ->
    res.json 'test'

  router.get '/v1/books/list',(req,res) ->
    book = new Book req.query
    book.search (err,data) ->
      if not err?
        res.json data.books

  #
  # book api
  #

  router.get '/v1/book/detail/:isbn',(req,res) ->
    book = new Book req.params
    book.detail (err,data) ->
      if not err?
        res.json data

  router.get '/oauth/douban',(req,res)->
    res.redirect 'https://www.douban.com/service/auth2/auth?response_type=code&client_id='+setting.douban_auth.client_id+'&redirect_uri='+setting.douban_auth.dev_host+'user/douban/callback'

  module.exports = router
