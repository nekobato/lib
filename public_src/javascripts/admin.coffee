$('#admin-post').on 'submit', () ->
  event.preventDefault()
  $.post $(this).attr('action'), $(this).serialize()
  .done (data) ->
    console.log data

$('#archive-select li').on 'click', () ->
  $.get '/archive/' + $(this).data('id') + '?format=json'
  .done (data) ->
    console.log data
    $("#admin-edit #post-id").val data.id
    $("#admin-edit #post-title").val data.title
    $("#admin-edit #post-body").val data.body

$('#admin-edit').on 'submit', () ->
  event.preventDefault()
  $.post $(this).attr('action'), $(this).serialize()
  .done (data) ->
    console.log data
