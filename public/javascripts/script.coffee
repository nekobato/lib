# call the article
$(".article").each (index) ->
	self = $(this)
	$.ajax("/api/" + self.data("id"))
	.done (msg) ->
		self.append msg
		# code change prettify
		prettyPrint();

$(".comment-opener").on "click", () ->
	$(this).next().toggle();

$(".comment-sender").on "submit", () ->
	event.preventDefault()
	$.ajax("/comment/", {
		type: "post"
		data: $(this).serialize()
	})
	.done (msg) ->
		console.log msg