command: "date +\"%a %d %b %Y %H:%M:%S\""

refreshFrequency: 1000

render: (output) ->
  "<div class='date'>#{output}</div>"

style: """
  -webkit-font-smoothing: antialiased
  color: #5F819D
  font: 11px Menlo
  top: 6px
  width: 100%

  .date
    text-align: center
"""
