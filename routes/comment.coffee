# POST /api/photo/:id/comment

# load modules
db = require "../lib/db"

exports.post = (req, res)->
	db.postComment
		id: req.params.id
		text: req.body.text
		user_id: req.body.user_id
	, (data)->
		res.json JSON.stringify(data)
