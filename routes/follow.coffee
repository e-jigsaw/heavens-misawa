# POST and DELETE /api/user/follow

# load modules
db = require "../lib/db"

exports.post = (req, res)->
	db.postFollow
		id: req.query.id
		followId: req.query.followId
	, (data)->
		res.json JSON.stringify(data)

exports.delete = (req, res)->
	db.deleteFollow
		id: req.query.id
		followId: req.query.followId
	, (data)->
		res.json JSON.stringify(data)
