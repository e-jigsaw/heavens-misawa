do ->
	path = location.pathname.split "/"
	$.get "/api/photo/#{path[2]}", (photo)->
		console.log photo
		$("#photoTmpl").tmpl(JSON.parse(photo)).appendTo("#content")