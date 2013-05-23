
refreshInterval = 60 * 1000 # 1 Minute

refresh = ->
  $.get document.URL, (response) ->
    $(".widget").html(response)

setInterval(refresh, refreshInterval)
