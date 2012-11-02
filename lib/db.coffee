# accsess to Database

# load modules
mongoose = require "mongoose"
Schema = mongoose.Schema

error = require "./error"

# connect to DB
db = mongoose.createConnection process.env.MONGOLAB_URI

# ユーザのスキーマ
userSchema = mongoose.Schema
	user_id:
		type: Number
		required: true
		unique: true
	twitter:
		type: String
	twitter_secret:
		type: String
	name:
		type: String
	following:
		type: Number
	follower:
		type: Number

# 写真のスキーマ
photoSchema = mongoose.Schema
	id:
		type: Number
		required: true
		unique: true
	date:
		type: Date
	photo_url:
		type: String
		required: true
	user:
		type: Schema.Types.ObjectId
		ref: "users"
		required: true
	comments: [
		user:
			type: Schema.Types.ObjectId
			ref: "users"
		text:
			type: String
	]
	likes: [
		user:
			type: Schema.Types.ObjectId
			ref: "users"
	]

# follow のスキーマ
followSchema = mongoose.Schema
	user_id:
		type: Number
		required: true
		unique: true
	follow_users: [
		type: Schema.Types.ObjectId
		ref: "users"
	]

# define models
userModel = db.model "users", userSchema
photoModel = db.model "photos", photoSchema
followingModel = db.model "followings", followSchema
followerModel = db.model "followers", followSchema

# get photo data
exports.getPhoto = (req, callback)->
	# call database
	photoModel.findOne
		id: req.id
	, (err, photo)->
		if !err && doc.length > 0
			# make responce object
			res = 
				error: false
				errorCode: 0
				id: photo.id
				url: photo.photo_url
				date: photo.date
				user:
					user_id: photo.user.user_id
					name: photo.user.name
				comments: []
				likes: []

			for comment in photo.comments
				res.comments.push comment

			for like in photo.likes
				res.likes.push like

			callback res
		else
			error.make 0, (res)->
				callback res

# post photodata
exports.postPhoto = (req, callback)->
	photoModel.count (err, num)->
		if !err
			userModel.findOne
				user_id: req.user_id
			, (err, user)->
				if !err
					# make photo data
					photo = new photoModel
						id: num+1
						date: new Date()
						photo_url: req.photo_url
						user: user._id
						comments: []
						likes: []

					photo.save (err)->
						if !err
							callback
								error: false
								errorCode: 0
								id: num+1
						else
							error.make 0, (res)->
								callback res
				else 
					error.make 0, (res)->
						callback res
		else
			error.make 0, (res)->
				callback res

exports.deletePhoto = (req, callback)->

exports.getFeed = (req, callback)->
	photoModel.find({}).populate("user").populate("comments.user").populate("likes.user").exec (err, photos)->
		if !err
			res =
				error: false
				errorCode: 0
				photos: []

			for photo in photos
				photo = 
					id: photo.id
					user:
						user_id: photo.user.user_id
						name: photo.user.name
					photo_url: photo.photo_url
					comments: []
					likes: []
				for comment in photo.comments
					comment =
						text: comment.text
						user:
							user_id: comment.user.user_id
							name: comment.user.name
					photo.comments.push comment
				for like in photo.likes
					like =
						user:
							user_id: like.user.user_id
							name: like.user.name
					photo.likes.push like
				res.photos.push photo

			callback res
		else 
			error.make 0, (res)->
				callback res

# get user data
exports.getUser = (req, callback)->
	# call database
	userModel.findOne
		user_id: req.user_id
	, (err, user)->
		if !err
			# make responce object
			res =
				error: false
				errorCode: 0
				user_id: user.user_id
				name: user.name
				photos: []

			photoModel.find
				user_id: req.user_id
			, (err, photos)->
				if !err
					for photo in photos
						res.photos.push photo
					callback res
				else
					error.make 0, (res)->
						callback res
		else
			error.make 0, (res)->
				callback res

# post user data (new create)
exports.postUser = (req, callback)->
	userModel.count (err, num)->
		# make new user
		user = new userModel
			user_id: num+1
			uuid: req.uuid
			name: req.name
			following: 0
			follower: 0

		user.save (err)->
			if !err
				callback
					error: false
					errorCode: 0
					id: num+1
			else
				error.make 0, (res)->
					callback res

exports.putUser = (req, callback)->

exports.postFollow = (req, callback)->

exports.deleteFollow = (req, callback)->

# post comment(new create)
exports.postComment = (req, callback)->
	# search database by key
	photoModel.findOne
		id: req.id
	, (err, photo)->
		if !err 
			userModel.findOne
				user_id: req.user_id
			, (err, user)->
				if !err
					# make comment
					comment =
						user: user._id
						text: req.text

					photo.comments.push comment

					photo.save (err)->
						if !err
							callback
								error: false
								errorCode: 0
						else
							error.make 0, (res)->
								callback res
				else
					error.make 0, (res)->
						callback res
		else
			error.make 0, (res)->
				callback res

# post like
exports.postLike = (req, callback)->
	# search database by key
	photoModel.findOne
		id: req.id
	, (err, photo)->
		if !err
			userModel.findOne
				user_id: req.user_id
			, (err, user)->
				console.log photo, user
				if !err
					# make like
					like =
						user: user._id

					photo.likes.push like

					photo.save (err)->
						if !err
							callback
								error: false
								errorCode: 0
						else
							error.make 0, (res)->
								callback res
				else
					error.make 0, (res)->
						callback res
		else
			error.make 0, (res)->
				callback res
