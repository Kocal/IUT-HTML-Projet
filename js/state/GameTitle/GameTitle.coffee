class GameTitle

  constructor: (@game) ->
    console.log 'GameTitle::constructor()' if debug

  preload: ->
    console.log 'GameTitle::preload()' if debug
    @game.load.image 'logo', '/assets/img/logo.png'
    @game.load.image 'buttonPlay', '/assets/img/buttonPlay.png'
    @game.load.image 'orangeTrace', '/assets/img/orangeTrace.png'

  create: ->
    console.log 'GameTitle::create()' if debug

    # Ajout de la texture qui accueillera les tracés lumineux
    @texture = @game.add.renderTexture @game.world.width, @game.world.height, 'mousetrail'
    @game.add.sprite 0, 0, @texture

    # Ajout du logo
    @sLogo = @game.add.sprite @game.world.centerX, @game.world.centerY, 'logo'
    @sLogo.anchor.setTo 0.5, 1

    # Ajout du bouton play
    @sButtonPlay = @game.add.button @game.world.centerX, @sLogo.y, 'buttonPlay', @onButtonPlayClick, @, 0, 1, 2
    @sButtonPlay.anchor.setTo 0.5, -1

    @traces = @game.make.group()

    for i in [0..6]
      @traces.add @_initATrace()

  update: ->
    console.log 'GameTitle::update()' if debug

    for trace in @traces.children
      @texture.renderXY trace, trace.x, trace.y

  onButtonPlayClick: ->
    console.log 'Jouer'

  _initATrace: ->
    isHorizontal = Math.random() >= 0.5

    velocity = Math.random() * 50 + 10
    x = Math.random() * @game.width;
    y = 0;

    trace = @game.make.sprite 0, 0, 'orangeTrace'
    @game.physics.enable trace, Phaser.Physics.ARCADE

    if isHorizontal
      [x, y] = [y, x]
      trace.body.velocity.x = velocity
      angle = 270
    else
      trace.body.velocity.y = velocity
      angle = 0

    trace.angle = angle
    trace.x = x;
    trace.y = y;

    return trace