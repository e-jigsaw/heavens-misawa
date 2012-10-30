# GET /api/feed

# load modules
db = require "../lib/db"

exports.get = (req, res)->
	db.getFeed req.query.id, (data)->
		res.json JSON.stringify(data)
