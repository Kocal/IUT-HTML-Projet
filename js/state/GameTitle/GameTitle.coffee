class GameTitle

  constructor: (@game) ->
    console.log 'GameTitle::constructor()' if debug

  preload: ->
    console.log 'GameTitle::preload()' if debug

  create: ->
    console.log 'GameTitle::create()' if debug

  update: ->
    console.log 'GameTitle::update()' if debug
    