# GET and POST and DELETE /api/photo

# load modules
db = require "../lib/db"

exports.get = (req, res)->
	db.getPhoto req.query.id, (data)->
		res.json JSON.stringify(data)

exports.post = (req, res)->
	db.postPhoto req.query.id, req.body.photo, (data)->
		res.json JSON.stringify(data)

exports.delete = (req, res)->
	db.deletePhoto req.query.id, (data)->
		res.json JSON.stringify(data)
