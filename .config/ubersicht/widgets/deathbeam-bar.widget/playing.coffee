command: 'echo $(cat $HOME/.config/song.txt)'
refreshFrequency: 1000 # ms

render: (output) ->
  """
  <div class="np"
    <span></span>
    <span class="icon fa fa-play-circle-o"></span>
  </div>
  """

update: (output, el) ->
    # data = JSON.parse(output)
    # artist = data.recenttracks.track[0].artist["#text"]
    # song = data.recenttracks.track[0].name
    # output = "#{song} - #{artist}"
    $(".np span:first-child", el).text("  #{output}")

style: """
  -webkit-font-smoothing: antialiased
  text-align: center
  color: #d5c4a1
  font: 10px Input
  font: 13px Inconsolata
  height: 16px
  left: 25%
  overflow: hidden
  text-overflow: ellipsis
  top: 6px
  width: 50%
"""
