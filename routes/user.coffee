# GET and POST /api/user

# load modules
db = require "../lib/db"

exports.get = (req, res)->
	db.getUser req.query.id, (data)->
		res.json JSON.stringify(data)

exports.post = (req, res)->
	db.postUser
		facebook: req.query.facebook
		twitter: req.query.twitter
		name: req.query.name
	, (data)->
		res.json JSON.stringify(data)