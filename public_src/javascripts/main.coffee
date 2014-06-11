$('#formzone').on 'submit', () ->
  event.preventDefault()
  $.post '/admin/post', $(this).serialize()
  .done (data) ->
    console.log data

# $('#formzone').dropzone
#   url: $(this).attr 'action'
#   data: $(this).children('input[name="title"]').value()
