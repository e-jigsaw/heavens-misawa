# main server script
http = require "http"
path = require "path"
express = require "express"
routes = require "./routes"

app = express()
server = http.createServer app

app.configure ->
	app.set "port", process.env.PORT || 3000
	app.use express.favicon()
	app.use express.logger "dev"
	app.use app.router
	app.use express.static(path.join __dirname, "public")

app.configure "development", ->
	app.use express.errorHandler()

app.get "/", routes.index

server.listen app.get("port"), ->
	console.log "listening on port: #{app.get("port")}"
