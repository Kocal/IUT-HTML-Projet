class GamePlay

  moteur: null

  spriteMoto1: null
  spriteMoto2: null
  spriteMoto3: null
  spriteMoto4: null

  spriteG: null
  spriteD: null

  constructor: (@game) ->
    console.log 'GamePlay::construct()' if debug
    @moteur = new tronEngine(500,500)

  preload: ->
    console.log 'GamePlay::preload()' if debug
    game.load.image 'fleche_gauche', 'assets/fleche_gauche.png'
    game.load.image 'fleche_droite', 'assets/fleche_droite.png'

    game.load.image 'moto1', 'assets/bike.png'
    game.load.image 'moto2', 'assets/bike.png'
    game.load.image 'moto3', 'assets/bike.png'
    game.load.image 'moto4', 'assets/bike.png'

  create: ->
    console.log 'GamePlay::create()' if debug

    @spriteMoto1 = game.add.sprite(@moteur.player1.posX, @moteur.player1.posY, 'moto1');

    game.physics.startSystem(Phaser.Physics.ARCADE);
    game.physics.arcade.enable([@spriteMoto1]);
    #game.physics.arcade.gravity.y = 200;


    @spriteG = game.add.sprite(0, 0, 'fleche_gauche');
    @spriteG.scale.setTo(0.2, 0.2);

    @spriteD = game.add.sprite(50, 0, 'fleche_droite');
    @spriteD.scale.setTo(0.2, 0.2);

    #  Enables all kind of input actions on this image (click, etc)
    @spriteG.inputEnabled = true;
    @spriteG.events.onInputDown.add(@listenerBoutonG, this);

    #  Enables all kind of input actions on this image (click, etc)
    @spriteD.inputEnabled = true;
    @spriteD.events.onInputDown.add(@listenerBoutonD, this);


  listenerBoutonG: () ->
    console.log "bonton gauche" if debug
    @moteur.player1.tourneGauche()

  listenerBoutonD: () ->
    console.log "bonton droit" if debug
    @moteur.player1.tourneDroite()

  update: ->

    console.log 'GamePlay::update()' if debug

    @moteur.nextStep()


    @spriteMoto1.body.velocity.x = @moteur.player1.getVelocityX()
    @spriteMoto1.body.velocity.y = @moteur.player1.getVelocityY()

    #@spriteMoto1.position(@moteur.player1.posX, @moteur.player1.posY)






