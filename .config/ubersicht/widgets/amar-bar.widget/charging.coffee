command: "pmset -g batt | grep 'AC Power' -o;"

refreshFrequency: 15000 # ms

render: (output) ->
  """
  <div class="charging"
    <span></span>
    <span class="icon fa"></span>
  </div>
  """

update: (output, el) ->
  $(".charging span:first-child", el)
  elIcon = $(".charging span.icon", el)
  elIcon.removeClass().addClass("icon fa #{@icon(output)}")

icon: (output) =>
  return if output is "AC Power\n"
    "fa-bolt"
  else
    ""

style: """
  -webkit-font-smoothing: antialiased
  top: 4px
  right: 182px
  right: 247px
  color: #d5c4a1
"""
