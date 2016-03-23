class GameTitle

  constructor: (@game) ->
    console.log 'GameTitle::constructor()' if debug

  preload: ->
    console.log 'GameTitle::preload()' if debug
    @game.load.image 'buttonPlay', '/assets/img/buttonPlay.png'

  create: ->
    console.log 'GameTitle::create()' if debug

    @buttonPlay = @game.add.button @game.world.centerX, @game.world.centerY, 'buttonPlay', @onButtonPlayClick, @, 0, 1, 2
    @buttonPlay.anchor.setTo 0.5, 0.5

  update: ->
    console.log 'GameTitle::update()' if debug

#    @buttonPlay.x = @game.world.centerX
#    @buttonPlay.y = @game.world.centerY

  onButtonPlayClick: ->
    console.log 'Jouer'