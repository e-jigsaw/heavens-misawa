module.exports = (grunt)->
	# project config
	grunt.initConfig
		pkg: "<json:package.json>"

		# compile coffeescript
		coffee:

			# grunt 
			self:
				src: ["grunt.coffee"]
				dest: "./"
				options:
					bare: true

			# application
			app:
				src: ["app.coffee"]
				dest: "./"
				options:
					bare: true

			# routes
			routes:
				src: ["routes/*.coffee"]
				dest: "routes/"
				options:
					bare: true

			# library
			lib:
				src: ["lib/*.coffee"]
				dest: "lib/"
				options:
					bare: true

		# file watch
		watch:
			files: ["app.coffee", "grunt.coffee", "routes/*.coffee", "lib/*.coffee"]
			tasks: "coffee"

	# load modules
	grunt.loadNpmTasks "grunt-coffee"

	# register default task
	grunt.registerTask "default", "watch"