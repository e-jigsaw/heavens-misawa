# make error responce

exports.make = (code, callback)->
	callback
		error: true
		errorCode: code