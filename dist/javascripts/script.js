(function() {
  $(".article").each(function(index) {
    var self;
    self = $(this);
    return $.ajax("/api/" + self.data("id")).done(function(msg) {
      self.append(msg);
      return prettyPrint();
    });
  });

  $(".comment-opener").on("click", function() {
    return $(this).next().toggle();
  });

  $(".comment-sender").on("submit", function() {
    event.preventDefault();
    return $.ajax("/comment/", {
      type: "post",
      data: $(this).serialize()
    }).done(function(res) {
      return $(this).prev().append("<li>" + res.body + "</li>");
    }).error(function(err) {
      $(this + " > input[type=submit]").value = "Error";
      return setTimeout(function() {
        return $(this + " > input[type=submit]").value = "Send";
      }, 2000);
    });
  });

}).call(this);

/*
//@ sourceMappingURL=script.js.map
*/