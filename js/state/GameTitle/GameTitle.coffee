class GameTitle

  constructor: (@game) ->
    console.log 'GameTitle::constructor()' if debug

    @buttonsPlayer = [
      'buttonOnePlayer', 'buttonTwoPlayers', 'buttonThreePlayers', 'buttonFourPlayers'
    ]

  preload: ->
    console.log 'GameTitle::preload()' if debug
    @game.load.image 'logo', 'assets/img/logo.png'

    for buttonPlayer in @buttonsPlayer
      @game.load.image buttonPlayer, "assets/img/#{buttonPlayer}.png"

    @game.load.image 'orangeTrace', 'assets/img/orangeTrace.png'
    @game.load.image 'blueTrace', 'assets/img/blueTrace.png'

    return

  create: ->
    console.log 'GameTitle::create()' if debug
    self = @

    @sButtonPlay = undefined

    #couleur de fond
    game.stage.backgroundColor = '#000000'

    @randomGenerator = new Phaser.RandomDataGenerator

    # Ajout de la texture qui accueillera les tracés lumineux
    @texture = @game.add.renderTexture @game.world.width, @game.world.height, 'mousetrail'
    @game.add.sprite 0, 0, @texture

    # Génération des tracés
    @traces = @game.make.group()
    @traces.add @_initATrace() for i in [0..5]

    # On ajout un tracé supplémentaire toutes les 5 secondes
    @game.time.events.loop 5000, =>
      @traces.add @_initATrace()
    , @

    # Ajout du logo
    @sLogo = @game.add.sprite @game.world.centerX, @game.world.centerY - 100, 'logo'
    @sLogo.anchor.setTo 0.5, 1

    for buttonPlayer, i in @buttonsPlayer
      y = if @sButtonPlay? then @sButtonPlay.y else @sLogo.y

      @sButtonPlay = @game.add.button @game.world.centerX, y + 60, buttonPlayer, do (i) ->
          ->
            self.onButtonPlayClick i+1
      , @, 0, 1, 2
      @sButtonPlay.anchor.setTo 0.5, -1

    return

  update: ->
    console.log 'GameTitle::update()' if debug

    for trace in @traces.children
      @texture.renderXY trace, trace.x, trace.y

      if trace.x >= @game.width || trace.y >= @game.height
        trace.x = Math.random() * @game.width
        trace.y = 0

    return


  onButtonPlayClick: (players) ->
    console.log players
    @game.state.start 'GamePlay', true, true, players

    return

  _initATrace: ->
    isOrange = Math.random() >= 0.5
    x = Math.random() * @game.width
    y = Math.random() * -150

    trace = @game.make.sprite x, y, if isOrange then 'orangeTrace' else 'blueTrace'
    @game.physics.enable trace, Phaser.Physics.ARCADE

    trace.anchor.setTo 0.5
    trace.body.velocity.y = 30

    return trace