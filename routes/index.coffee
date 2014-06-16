#!/usr/bin/env coffee

express = require("express")
router = express.Router()
fs = require("fs")
path = require("path")
moment = require('moment')

# GET home page.
router.get "/", (req, res) ->
  model = require req.app.get("models")
  model.getArchive [10, 0], (err, rows) ->
    model.getArticle rows[0].id, (err, data) ->
      res.render "index",
        title: "nekobato lib - #{rows[0].title}"
        archive: rows
        article:
          id: rows[0].id
          title: rows[0].title
          date: moment(rows[0].date).format('YYYY.MM.DD')
          body: data
  return

router.get "/archive/:id", (req, res) ->
  model = require req.app.get("models")
  model.getArchive req.params.id, (err, rows) ->
    rows[0].body = model.getArticleSync req.params.id
    rows[0].date = moment(rows[0].date).format('YYYY.MM.DD')
    res.json rows[0] if req.query.format is 'json'
    res.render "article",
      title: "nekobato.lib"
      article: rows[0]
  return

router.get "/rss", (req, res) ->
  model = require req.app.get("models")
  model.getArchive [10, 0], (err, rows) ->
    for row in rows
      row.body = model.getArticleSync row.id
    res.render "rss",
      archive: rows

router.get "/archive", (req, res) ->
  model = require req.app.get("models")
  limit = 10 unless req.query.limit
  offset = 0 unless req.query.offset
  model.getArchive [limit, offset], (err, rows) ->
    if req.query.format is 'json'
      res.json { archive: rows }
    else
      res.render "archive",
        archive: rows

router.get "/admin", (req, res) ->
  model = require req.app.get("models")
  model.getArchive [10, 0], (err, rows) ->
    res.render "admin",
      archive: rows

router.post "/admin/post",  (req, res, next) ->
  model = require req.app.get("models")
  data =
    title: req.body.title
    file: req.body.body
  model.post data, (err, id) ->
    res.send err if err
    res.send id

router.post "/admin/edit",  (req, res, next) ->
  model = require req.app.get("models")
  id = req.body.id
  data =
    title: req.body.title
    body: req.body.body
  model.edit id, data, (err, id) ->
    res.send err if err
    res.send id

module.exports = router
