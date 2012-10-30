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
		id: req.params.id
		photo: req.body.photo
	, (data)->
		res.json JSON.stringify(data)

exports.delete = (req, res)->
	db.deletePhoto
		id: req.params.id
	, (data)->
		res.json JSON.stringify(data)
