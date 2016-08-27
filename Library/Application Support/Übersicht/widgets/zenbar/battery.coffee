command: "pmset -g batt | egrep '([0-9]+\%).*' -o --colour=auto | cut -f1 -d';'"

refreshFrequency: 150000 # ms

render: (output) ->
  "bat <span>#{output}</span>"

style: """
  -webkit-font-smoothing: antialiased
  font: 11px Menlo
  top: 6px
  right: 10px
  color: #F0C674
  span
    color: #BE3E64
"""

# color: #eee8d5
