
refreshInterval = 60 * 1000 # 1 Minute

handleRefresh = ->
  document.querySelector(".widget").innerHTML = this.response

refresh = ->
  xhr = new XMLHttpRequest()
  xhr.onload = handleRefresh
  xhr.open("get", window.location.href, true)
  xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest")
  xhr.send()
  console.log "loading", window.location.href

setInterval(refresh, refreshInterval)
