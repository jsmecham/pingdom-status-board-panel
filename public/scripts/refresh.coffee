
refreshInterval = 60 * 1000 # 1 Minute

refresh = ->
  path = window.location.pathname
  queryString = window.location.search.substring(1)
  queryString = queryString.replace("/", "")
  $.get path, queryString, (response) ->
    $(".widget").html(response)

setInterval(refresh, refreshInterval)
