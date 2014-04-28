'use strict'

module.exports = (grunt) ->

  pkg = grunt.file.readJSON 'package.json'

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  # grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  # grunt.loadNpmTasks 'grunt-contrib-csslint'
  # grunt.loadNpmTasks 'grunt-contrib-imagemin'
  # grunt.loadNpmTasks 'grunt-contrib-clean'
  # grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  # grunt.loadNpmTasks 'grunt-htmlhint'
  # grunt.loadNpmTasks 'grunt-coffeelint'
  # grunt.loadNpmTasks 'grunt-simple-mocha'
  # grunt.loadNpmTasks 'grunt-notify'

  grunt.registerTask 'build', [
    'buildjs'
    'buildcss'
  ]

  grunt.registerTask 'default', [
    'build'
    'express:dev'
    'watch'
  ]

  grunt.registerTask 'buildjs', [
    'coffee:dist'
    'uglify'
  ]

  grunt.registerTask 'buildcss', [
    'stylus:dist'
  ]

  grunt.initConfig

    pkg: pkg

    express:
      options:
        opts: ['node_modules/coffee-script/bin/coffee']
        script: './bin/www'
        port: 3000
        fallback: () ->
          console.log "*** Error ***"
      dev:
        options:
          node_env: 'development'
          delay: 500
          debug: false

    coffee:
      dist:
        options:
          sourceMap: yes
          sourceMapDir: 'assets/'
        files: [{
          expand: yes
          cwd: 'assets'
          src: [ '**/*.coffee' ]
          dest: 'public'
          ext: '.js'
        }]

    stylus:
      dist:
        options:
          compress: no
        files: [{
          expand: yes
          cwd: 'assets'
          src: [ '**/*.styl' ]
          dest: 'public'
          ext: '.css'
        }]

    uglify:
      dist:
        files: [{
          expand: yes
          cwd: 'dist'
          src: [ '**/*.js', '!**/*.min.js' ]
          dest: 'public'
          ext: '.js'
        }]

    jade:
      dist:
        options:
          pretty: yes
        files: [{
          expand: yes
          cwd: 'assets'
          src: [ '**/*.jade' ]
          dest: 'public'
          ext: '.html'
        }]

    watch:
      options:
        livereload: yes
        interrupt: yes
        nospawn: true
      coffee:
        tasks: [ 'buildjs' ]
        files: [ 'assets/**/*.coffee' ]
      stylus:
        tasks: [ 'buildcss' ]
        files: [ 'assets/**/*.styl' ]
      debug:
        tasks: [ 'express:dev' ]
        files: [
          'app.coffee', '{bin,lib,routes,test}/**/*.{js,coffee}', 'bin/www'
        ]