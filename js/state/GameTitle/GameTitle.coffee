class GameTitle

  constructor: (@game) ->
    console.log 'GameTitle::constructor()' if debug

  preload: ->
    console.log 'GameTitle::preload()' if debug
    @game.load.image 'logo', '/assets/img/logo.png'
    @game.load.image 'buttonPlay', '/assets/img/buttonPlay.png'

  create: ->
    console.log 'GameTitle::create()' if debug

    @sLogo = @game.add.sprite @game.world.centerX, @game.world.centerY, 'logo'
    @sLogo.anchor.setTo 0.5, 1

    @sButtonPlay = @game.add.button @game.world.centerX, @sLogo.y, 'buttonPlay', @onButtonPlayClick, @, 0, 1, 2
    @sButtonPlay.anchor.setTo 0.5, -1

  update: ->
    console.log 'GameTitle::update()' if debug

#    @buttonPlay.x = @game.world.centerX
#    @buttonPlay.y = @game.world.centerY

  onButtonPlayClick: ->
    console.log 'Jouer'