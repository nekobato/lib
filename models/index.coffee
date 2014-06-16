fs = require('fs')
path = require('path')
moment = require('moment')
sqlite3 = require('sqlite3').verbose()
db = new sqlite3.Database('./db.sqlite3')
_ = require('lodash')

articleModel = () ->

articleModel.post = (data, callback) ->
  id = moment().format('YYYY-MM-DD')
  date = moment().utc().format()
  db.run "INSERT INTO `archive` VALUES($id, $date, $title)"
    , [id, date, data.title]
  fs.writeFile "./archive/#{id}", data.body, (err) ->
    callback err, id

articleModel.edit = (id, data, callback) ->
  db.run "UPDATE `archive` SET title = $title WHERE id = $id"
    , [id, data.title]
  fs.writeFile "./archive/#{id}", data.body, (err) ->
    callback err, id

articleModel.get = (id, callback) ->
  db.all "SELECT * FROM `archive` WHERE `id` = $id"
    , [id], (err, rows) ->
    callback(err, rows)

articleModel.getArchive = (range, callback) ->
  query = if _.isArray range
    "SELECT * FROM archive ORDER BY date DESC LIMIT #{range[0]} OFFSET #{range[1]}"
  else if _.isString range
    "SELECT * FROM archive WHERE id = '#{range}'"
  db.all query, (err, rows) ->
    callback(err, rows)

articleModel.getArticle = (id, callback) ->
  fs.readFile path.resolve('./archive', id), (err, data) ->
    callback(err, data)

articleModel.getArticleSync = (id) ->
  return fs.readFileSync path.resolve('./archive', id), { encoding: 'utf-8' }

module.exports = articleModel
