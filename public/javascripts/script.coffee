$ ->
	$(".article").each (index) ->
		self = $(this)
		$.ajax("/api/" + self.data("id"))
		.done (msg) ->
			self.append msg