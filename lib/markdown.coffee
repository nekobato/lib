marked = require 'marked'
fs = require 'fs'

fs.readFile './test.md', "utf-8", (err, file) ->
  throw err if err

  marked file, (err, file) ->
    throw err if err

    console.log file