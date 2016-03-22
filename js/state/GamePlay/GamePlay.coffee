class GamePlay

  constructor: (@game) ->
    console.log 'GamePlay::construct()' if debug

  preload: ->
    console.log 'GamePlay::preload()' if debug

  create: ->
    console.log 'GamePlay::create()' if debug

  update: ->
    console.log 'GamePlay::update()' if debug
        
