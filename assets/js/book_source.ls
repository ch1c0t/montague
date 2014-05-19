$ ->
  $('#path').on 'input', (e) ->
    input = $(@).val!
    return if input == ''

    data = JSON.stringify do
      pathname: window.location.pathname
      id:       ($(@).attr 'id')
      type:     e.type
      input:    input

    s.send data
