command: "date +\"%a %d %b\""

refreshFrequency: 10000

render: (output) ->
  """
  <div class="cal"
    <span></span>
    <span class="icon fa fa-calendar"></span>
  </div>
  """

update: (output, el) ->
  $(".cal span:first-child", el).text("  #{output}")

style: """
  -webkit-font-smoothing: antialiased
  color: #d5c4a1
  font: 10px Input
  font: 13px Inconsolata
  right: 93px
  top: 6px
"""
