# main server script

# load modules
http = require "http"
path = require "path"
express = require "express"
routes = require "./routes"
photo = require "./routes/photo"
feed = require "./routes/feed"
user = require "./routes/user"
follow = require "./routes/follow"

# express settings
app = express()
server = http.createServer app

app.configure ->
	app.set "port", process.env.PORT || 3000
	app.use express.favicon()
	app.use express.logger "dev"
	app.use app.router
	app.use express.static(path.join __dirname, "public")
	app.use bodyDecoder()

app.configure "development", ->
	app.use express.errorHandler()

# routing 
app.get "/", routes.index
app.get "/api/photo/:id", photo.get
app.post "/api/photo/:id", photo.post
app.delete "/api/photo/:id", photo.delete
app.get "/api/feed/:id", feed.get
app.get "/api/user/:id", user.get
app.post "/api/user/:id", user.post
app.post "/api/user/follow/:id", follow.get
app.delete "/api/user/follow/:id", follow.delete

# server start
server.listen app.get("port"), ->
	console.log "listening on port: #{app.get("port")}"
