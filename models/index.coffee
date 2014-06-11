fs = require('fs')
moment = require('moment')
sqlite3 = require('sqlite3').verbose()
db = new sqlite3.Database('./db.sqlite3')

articleModel = () ->

articleModel.post = (data, callback) ->
  id = moment().format('YYYY-MM-DD')
  date = moment().utc().format()
  console.log id, date
  db.run "INSERT INTO `archive` VALUES($id, $date, $title)"
    , [id, date, data.title]
  fs.writeFile "./archive/#{id}", data.file, (err) ->
    callback err, id

articleModel.get = (id, callback) ->
  db.all "SELECT * FROM `archive` WHERE `id` = #{id}", (err, rows) ->
    callback(err, rows)

module.exports = articleModel
