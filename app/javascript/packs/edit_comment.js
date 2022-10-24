
$(function(){
  $(document).on("click", '.js-edit-comment-button', function(e){
    e.preventDefault()
    const commentId = $(this).data("comment-id")
    switchToEdit(commentId)
  })

  $(document).on("click", '.js-cancel-edit-comment-button', function() {
    clearErrorMessages()
    const commentId = $(this).data("comment-id")
    switchToLabel(commentId)
  })

  $(document).on("click", '.js-update-comment-button', function() {
    clearErrorMessages()
    const commentId = $(this).data("comment-id")
    submitComment($("#textarea-comment-" + commentId).val(), commentId)
        .then(result => {
            $("#comment-body-" + result.comment.id).html('<p>' + result.comment.body.replace(/\r?\n/g, '<br>') + '</p>')
            switchToLabel(result.comment.id)
        })
        .catch(result => {
            const commentId = result.responseJSON.comment.id
            const messages = result.responseJSON.errors.messages
            showErrorMessages(commentId, messages)
        })
  })

  function switchToEdit(commentId) {
    $("#show-comment-" + commentId).hide()
    $("#edit-comment-" + commentId).show()
  }

  function switchToLabel(commentId) {
    $("#show-comment-" + commentId).show()
    $("#edit-comment-" + commentId).hide()
  }

  function showErrorMessages(commentId, messages) {
    $('<p class="error-message alert alert-danger me-3 mb-2 py-2">' + messages.join('<br>') + '</p>').insertBefore($("#textarea-comment-" + commentId))
  }

  function submitComment(body, commentId) {
    return new Promise(function(resolve, reject) {
        $.ajax({
            type: 'PATCH',
            url: '/comments/' + commentId,
            data: {
                comment: {
                    body: body
                },
                authenticity_token: $('meta[name="csrf-token"]').attr('content')
            }
        }).done(function (result) {
            resolve(result)
        }).fail(function (result) {
            reject(result)
        })
    })
  }

  function clearErrorMessages() {
    $("p.error-message").remove()
  }
})