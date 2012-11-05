# GET and POST /api/user

# load modules
db = require "../lib/db"

exports.get = (req, res)->
	db.getUser
		user_id: req.params.id
	, (data)->
		res.json JSON.stringify(data)

exports.post = (req, res)->
	db.postUser
		uuid: req.body.uuid
		name: req.body.name
	, (data)->
		res.json JSON.stringify(data)

exports.put = (req, res)->
	db.putUser
		facebook: req.query.facebook
		twitter: req.query.twitter
		name: req.query.name
	, (data)->
		res.json JSON.stringify(data)
