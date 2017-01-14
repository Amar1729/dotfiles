command: "pmset -g batt | grep 'AC Power' -o;"

refreshFrequency: 15000 # ms

render: (output) ->
  """
  <div class="charging"
    <span></span>
    <span class="icon fa"></span>
  </div>
  """

icon: (output) =>
  return if output
    "fa-bolt"
  else
    "fa-battery-empty"

style: """
  -webkit-font-smoothing: antialiased
  font: 9px Input
  font: 12px Inconsolata
  top: 7px
  right: 195px
  color: #d5c4a1
"""
