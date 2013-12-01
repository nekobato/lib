# call the article
$(".article").each (index) ->
	self = $(this)
	$.ajax("/api/" + self.data("id"))
	.done (msg) ->
		self.append msg
		# code change prettify
		prettyPrint()

$(".comment-opener").on "click", () ->
	$(this).next().toggle()

$(".comment-sender").on "submit", () ->
	event.preventDefault()
	$.ajax("/comment/", {
		type: "post"
		data: $(this).serialize()
	})
	.done (res) ->
		$(this).prev().append("<li>#{res.body}</li>")
	.error (err) ->
		$(this + " > input[type=submit]").value = "Error"
		setTimeout ->
			$(this + " > input[type=submit]").value = "Send"
		, 2000
