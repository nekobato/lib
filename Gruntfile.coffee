module.exports = (grunt) ->
  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    coffee:
      options:
        sourceMap: no
      dist:
        files: [{
          expand: yes
          cwd: 'public_src'
          src: [ '**/*.coffee' ]
          dest: 'public'
          ext: '.js'
        }]

    compass:
      options:
        noLineComments: true
        outputStyle: 'compressed'
        assetCacheBuster: true
      dist:
        options:
          sassDir: 'public_src/stylesheets'
          cssDir: 'public/stylesheets'

    watch:
      options:
        dateFormat: (time) ->
          grunt.log.writeln "The watch finished in #{time}ms"
      coffee:
        files: ['public_src/**/*.coffee']
        tasks: ['coffee']
      sass:
        files: ['public_src/**/*.sass']
        tasks: ['compass']

  # compile
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  # watch
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'build', ['coffee', 'compass']
  grunt.registerTask 'default', ['build', 'watch']
