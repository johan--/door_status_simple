source = new EventSource('/updates')
source.addEventListener 'message', (e) ->
  data = JSON.parse(e.data)

  if data.event == "status_update"
    $("[data-status]").attr("data-status", data.status)

  console.log e
  console.log data
