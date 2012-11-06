# GET and POST and DELETE /api/photo

# load modules
db = require "../lib/db"

exports.get = (req, res)->
	db.getPhoto
		id: req.params.id
	, (data)->
		res.json JSON.stringify(data)

exports.post = (req, res)->
	db.postPhoto 
		user_id: req.body.user_id
		photo_url: req.body.photo_url
	, (data)->
		res.json JSON.stringify(data)

exports.delete = (req, res)->
	db.deletePhoto
		id: req.params.id
	, (data)->
		res.json JSON.stringify(data)
