moment = require('moment')

articleModel = () ->
  db = require('sqlite3').Database('./db.sqlite3')

articleModel.post = (data, callback) ->
    id = moment().format('YYYY-MM-DD')
    date = moment().utc().format()
    db.run "INSERT INTO `archive` VALUES(#{id}, #{date}, #{data.title})"
    fs.writeFile "../archive/#{id}", data.article, (err) ->
      callback err, id

articleModel.get = (id, callback) ->
    db.all "SELECT * FROM `archive` WHERE `id` = #{id}", (err, rows) ->
      callback(err, rows)

module.exports = articleModel
