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


module.exports = router
