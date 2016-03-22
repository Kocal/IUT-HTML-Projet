class Boot

  constructor: (@game) ->
    console.log 'Boot::constructor()' if debug

  preload: ->
    console.log 'Boot::preload()' if debug

  create: ->
    console.log 'Boot::create()' if debug

    timer = @game.time.create()
    timer.add 1000, ->
      @game.state.start 'GameTitle'
    , this

    timer.start()