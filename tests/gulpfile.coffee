gulp = require('gulp')
coffee = require('gulp-coffee')
watch = require('gulp-watch')

src =
  js:  "public_src/javascripts/**/*.coffee"
  css: "public_src/stylesheets/**/*.sass"

pub =
  js:  "public/javascripts/"
  css: "public/stylesheets/"

gulp.task 'coffee', ->
  gulp.src src.js
    .pipe coffee
      bare: true
    .pipe gulp.dest pub.js

gulp.task 'watch', ->
  gulp.src src.js
    .pipe watch (files) ->
      files
        .pipe coffee
          bare:true
        .pipe gulp.dest pub.js

gulp.task 'default', ->
  gulp.run 'watch'
