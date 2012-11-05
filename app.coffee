# main server script

# load modules
http = require "http"
path = require "path"
express = require "express"
routes = require "./routes"
photo = require "./routes/photo"
comment = require "./routes/comment"
like = require "./routes/like"
feed = require "./routes/feed"
user = require "./routes/user"
follow = require "./routes/follow"
show = require "./routes/show"

# express settings
app = express()
server = http.createServer app

app.configure ->
	app.set "port", process.env.PORT || 3000
	app.set "views", "#{__dirname}/views"
	app.set "view engine", "jade"
	app.use require("less-middleware")(src: "#{__dirname}/public")
	app.use express.methodOverride()
	app.use express.bodyParser()
	app.use express.favicon()
	app.use express.logger "dev"
	app.use app.router
	app.use express.static(path.join __dirname, "public")

app.configure "development", ->
	app.use express.errorHandler()

# routing 
app.get "/", routes.index
app.get "/show/:id", show.index
app.get "/api/photo/:id", photo.get
app.post "/api/photo", photo.post
app.delete "/api/photo/:id", photo.delete
app.post "/api/photo/:id/comment", comment.post
app.post "/api/photo/:id/like", like.post
app.get "/api/feed/:id", feed.get
app.get "/api/user/:id", user.get
app.post "/api/user", user.post
app.post "/api/user/:id/edit", user.put
app.post "/api/user/follow/:id", follow.get
app.delete "/api/user/follow/:id", follow.delete

# server start
server.listen app.get("port"), ->
	console.log "listening on port: #{app.get("port")}"
