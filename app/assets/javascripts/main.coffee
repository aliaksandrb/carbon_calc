$( ->
  $(document).on('click','.pagination a[data-remote=true]', (e) ->
    history.pushState('', '', $(e.target).attr('href'))
  )
  $(window).bind('popstate', ->
    $.ajax({ url:window.location, dataType:'script' })
    return true
  )
)
