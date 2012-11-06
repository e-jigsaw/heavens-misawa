do->
	colum_cols = $(window).width() / 350
	i = 0
	while i < colum_cols - 1
		$("#columTmpl").tmpl().appendTo("#content")
		i++

	$.get "/api/feed/1", (data)->
		photos = JSON.parse data
		console.log photos
		for photo in photos.photos
			less = 0
			col = 0
			while col < $(".colum").length
				if $(".colum:eq(#{less})").height() > $(".colum:eq(#{col})").height()
					less = col
				col++
			$("#photoTmpl").tmpl(photo).appendTo(".colum:eq(#{less})")