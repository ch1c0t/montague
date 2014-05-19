@s = new SockJS('http://localhost:1025/stream/')
@s.onmessage = (e) ->
  data = JSON.parse e.data
  $('#' + data.id).html data.html
