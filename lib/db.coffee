# accsess to Database

# load modules
mongoose = require "mongoose"
fs = require "fs"

# connect to DB
db = mongoose.createConnection "mongo://#{process.env.MONGODB_USER}:#{process.env.MONGODB_PASS}@localhost/misawa"

# ユーザのスキーマ
userSchema = mongoose.Schema
	user_id:
		type: Number
		required: true
		unique: true
	facebook:
		type: String
	twitter:
		type: String
	name:
		type: String
	following:
		type: Number
	follower:
		type: Number
	isFacebookAvailable:
		type: Boolean
	isTwitterAvailable:
		type: Boolean

# 写真のスキーマ
photoSchema = mongoose.Schema
	id:
		type: Number
		required: true
		unique: true
	origin_id:
		type: Number
		required: true
	date:
		type: Date
	user_id:
		type: Number
		required: true
	user_name:
		type: String
		required: true
	comments: [
		text:
			type: String
			required: true
		user_id:
			type: Number
			required: true
	]
	likes: [
		user_id: 
			type: Number
	]

# 写真のコレクションのスキーマ
photoCollectionSchema = mongoose.Schema
	user_id:
		type: Number
		required: true
		unique: true
	photos: [
		id: 
			type: Number
			unique: true
	]

# following のスキーマ
followingSchema = mongoose.Schema
	user_id:
		type: Number
		required: true
		unique: true
	following_users: [
		user_id:
			type: Number
	]

# follower のスキーマ
followerSchema = mongoose.Schema
	user_id:
		type: Number
		required: true
		unique: true
	follower_users: [
		user_id:
			type: Number
	]

# define models
userModel = db.model "users", userSchema
photoModel = db.model "photos", photoSchema
photoCollectionModel = db.model "photoCollections", photoCollectionSchema
followingModel = db.model "followings", followingSchema
followerModel = db.model "followers", followerSchema

# get photo data
exports.getPhoto = (req, callback)->
	# call database
	photoModel.find
		id: req.id
	, (err, doc)->
		if !err
			# make responce object
			res = 
				error: false
				errorCode: 0
				id: doc[0].id
				origin_id: doc[0].origin_id
				date: doc[0].date
				user:
					id: doc[0].user_id
					name: doc[0].user_name
				comments: []
				likes: []

			for comment in doc[0].comments
				res.comments.push comment

			for like in doc[0].likes
				res.likes.push like

			callback res
		else
			callback
				error: true
				errorCode: 0

exports.postPhoto = (req, callback)->
	photoModel.count (err, num)->
		fs.writeFile "./public/images/blob/#{num+1}.jpg", req.photo, (err)->
			if !err
				userModel.find
					id: req.id
				, (err, doc)->
					photo = new photoModel
						id: num+1
						origin_id: num+1
						data: new Date()
						user_id: req.id
						user_name: doc[0].name
						comments: []
						likes: []

					photo.save (err)->
						if !err
							callback
								error: false
								errorCode: 0
								id: num+1
						else
							callback
								error: true
								errorCode: 0
			else 
				callback
					error: true
					errorCode: 0

exports.deletePhoto = (req, callback)->

exports.getFeed = (req, callback)->

exports.getUser = (req, callback)->
	# call database
	userModel.find
		id: req.id
	, (err, doc)->
		if !err
			# make responce object
			res =
				error: false
				errorCode: 0
				id: doc[0].id
				name: doc[0].name
				photos: []
			photoCollectionModel.find
				id: req.id
			, (err, doc)->
				if !err
					for photo in doc[0].photos
						res.photos.push photo
					callback res
				else
					callback
						error: true
						errorCode: 0
		else
			callback
				error: true
				errorCode: 0

exports.postUser = (req, callback)->

exports.putUser = (req, callback)->

exports.postFollow = (req, callback)->

exports.deleteFollow = (req, callback)->

exports.postComment = (req, callback)->

exports.postLike = (req, callback)->
