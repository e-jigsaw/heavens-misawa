# POST /api/photo/:id/comment

# load modules
db = require "../lib/db"

exports.post = (req, res)->
	db.postComment
		id: req.query.id
		text: req.body.text
		user_id: req.query.user_id
	, (data)->
		res.json JSON.stringify(data)
		