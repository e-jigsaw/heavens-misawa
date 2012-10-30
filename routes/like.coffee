# POST /api/photo/:id/like

# load modules
db = require "../lib/db"

exports.post = (req, res)->
	db.postLike
		id: req.query.id
		user_id: req.query.user_id
	, (data)->
		res.json JSON.stringify(data)
