# main server script
http = require "http"
path = require "path"
express = require "express"
routes = require "./routes"
photo = require "./routes/photo"
feed = require "./routes/feed"
user = require "./routes/user"
follow = require "./routes/follow"

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
app.get "/api/photo?*", photo.get
app.post "/api/photo?*", photo.post
app.delete "/api/photo?*", photo.delete
app.get "/api/feed?*", feed.get
app.get "/api/user?*", user.get
app.post "/api/user?*", user.post
app.get "/api/user/follow?*", follow.get
app.delete "/api/user/follow?*", follow.delete

server.listen app.get("port"), ->
	console.log "listening on port: #{app.get("port")}"
