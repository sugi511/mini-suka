echo = (x) ->
	console.log x
	$(".message").text(x)
$ -> 
	skirtline = false 
	$(".square").resizable()
	.draggable()
	
	$("#stop-first").click(()->
		sq = $ ".square"
		# action = skirtline ? "enable" : "disable"
		if skirtline
			action = "enable"
		else
			action = "disable"
		sq.resizable action
		sq.draggable action
		skirtline = !skirtline
	)

	$(".square").click( (e)->
		return false if skirtline

		img = $ "#main img"
		# echo img.width() 
		# echo img.height() 
		square = $ this
		main = $("#main")

		sqwidth = square.width()
		sqheight = square.height()
		clicked_point = e.pageY - square.offset().top
		topsq = $(".square .top")
		bottomsq = $(".square .bottom")

		topsq.css("display", "block").css("height", clicked_point)
		bottomsq.css("display", "block").css("height", sqheight-clicked_point)
	)

	$("#stop-second").click( ()->
		square = $(".square")
		img = $("#main > img")
		topsq = $(".square .top")
		bottomsq = $(".square .bottom")
		topsqW = $(".square .top .img-wrapper")
		bottomsqW = $(".square .bottom .img-wrapper")

		img.css("opacity", "0.5")

		topsqW.append("<img src='"+img.attr("src")+"' />")
		bottomsqW.append("<img src='"+img.attr("src")+"' />")

		topsq.y = topsq.offset().top - img.offset().top
		topsq.x = topsq.offset().left - img.offset().left
		$(".square .top .img-wrapper").css("width", img.width())
		$(".square .top .img-wrapper").css("height", img.height())
		$(".square .top .img-wrapper").css("top", -topsq.y)
		$(".square .top .img-wrapper").css("left", -topsq.x)

		bottomsq.y = bottomsq.offset().top - img.offset().top
		bottomsq.x = bottomsq.offset().left - img.offset().left
		$(".square .bottom .img-wrapper").css("width", img.width())
		$(".square .bottom .img-wrapper").css("height", img.height())
		$(".square .bottom .img-wrapper").css("top", -bottomsq.y)
		$(".square .bottom .img-wrapper").css("left", -bottomsq.x)

	)

	$("#up").click( ()->
		rate = 0.1
		square = $(".square")
		img = $("#main > img")
		topsq = $(".square .top")
		topsq_height = topsq.height()
		bottomsq = $(".square .bottom")
		bottomsq_height = bottomsq.height()
		topsqW = $(".square .top .img-wrapper")
		bottomsqW = $(".square .bottom .img-wrapper")
		topsq_top = topsqW.css("top")
		bottomsq_top = bottomsqW.css("top")

		diff = topsq_height * rate
		$(".square .top").css("height", topsq_height - diff)
		$(".square .bottom").css("height", bottomsq_height + diff)

		img = $(".square .top .img-wrapper img")
		height = img.css("height")
		height = parseInt(height.slice(0, -2), 10)
		$(".square .top .img-wrapper").css("width", img.width())
		$(".square .top .img-wrapper").css("height", height - diff)		
		$(".square .top .img-wrapper img").css("width", img.width())
		$(".square .top .img-wrapper img").css("height", height - diff)
		topsq.y = topsq_top * (topsq.height() / topsq_height)
		topsq.x = topsq.offset().left - img.offset().left
		$(".square .top .img-wrapper").css("top", -topsq.y+1)
		$(".square .top .img-wrapper").css("left", -topsq.x)

		img = $(".square .bottom .img-wrapper img")
		height = img.css("height")
		height = parseInt(height.slice(0, -2), 10)
		$(".square .bottom .img-wrapper").css("width", img.width())
		$(".square .bottom .img-wrapper").css("height", height + diff)
		$(".square .bottom .img-wrapper img").css("width", img.width())
		$(".square .bottom .img-wrapper img").css("height", height + diff)
		bottomsq.y = bottomsq_top * (bottomsq.height() / bottomsq_height)
		bottomsq.x = bottomsq.offset().left - img.offset().left
		$(".square .bottom .img-wrapper").css("top", -bottomsq.y+1)
		$(".square .bottom .img-wrapper").css("left", -bottomsq.x)		
	

	)

	$("#finish").click( ()->
		img = $("#main > img")
		img.css("opacity", "1")
		$(".square .top").css("border", "none")
		$(".square").css("border", "none")

		top_top = $(".square .top .img-wrapper").css("top")
		top_top = parseInt(top_top.slice(0,-2), 10)
		top_left = $(".square .top .img-wrapper").css("left")
		top_left = parseInt(top_left.slice(0,-2), 10)
		bottom_top = $(".square .bottom .img-wrapper").css("top")
		bottom_top = parseInt(bottom_top.slice(0,-2), 10)
		bottom_left = $(".square .bottom .img-wrapper").css("left")
		bottom_left = parseInt(bottom_left.slice(0,-2), 10)
		$(".square .top .img-wrapper").css("top", top_top + 2)
		$(".square .top .img-wrapper").css("left", top_left + 2)
		$(".square .bottom .img-wrapper").css("top", bottom_top + 2)
		$(".square .bottom .img-wrapper").css("left", bottom_left + 2)		



	)

	$(".skirt_area .btn").click( ()->
		name = $(this).attr("id")
		$("#main > img").attr("src", "img/"+name+".jpg")
	)