class Boot

  constructor: (@game) ->
    console.log 'Boot::constructor()' if debug

  preload: ->
    console.log 'Boot::preload()' if debug

  create: ->
    console.log 'Boot::create()' if debug
    @game.state.start 'GameTitle', true, true
