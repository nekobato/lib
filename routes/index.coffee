#!/usr/bin/env coffee

express = require("express")
router = express.Router()
fs = require("fs")
path = require("path")


# GET home page.
router.get "/", (req, res) ->
  res.render "index",
    title: "Express"
  return

router.get "/archive/:id", (req, res) ->
  fs.readFile path.resolve("./archive/", req.params.id)
  , (err, data) ->
    console.log err if err
    res.render "index",
      title: "nekobato.lib"
      article: data
  return

router.get "/admin", (req, res) ->
  res.render "admin"
  return

router.post "/admin/post", (req, res) ->
  model = req.app.get("models")
  data =
    title: req.query.title
    article: req.query.article
  model.post data, (err, id) ->
    res.send err if err
    res.send id

module.exports = router
