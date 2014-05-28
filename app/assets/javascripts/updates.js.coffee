source = new EventSource('/updates')
source.addEventListener 'message', (e) ->
  $("[data-status]").attr("data-status", e.data)
  console.log e.data
