class GamePlay

  moteur: null


  class Joueur
    spriteMoto: null
    lastWall : null
    lastWallPosition: null
    bmd: null
    color : '#ff0000'


  joueur1: Joueur
  joueur2: Joueur
  joueur3: Joueur
  joueur4: Joueur

  spriteG: null
  spriteD: null

  globalVelocity: 100
  epaisseurMur: 10

  prolongerMur : (joueur) ->


    if joueur.lastWall
      if joueur.spriteMoto.body.velocity.x > 0 # si on se deplace vers la droite
        joueur.lastWall.width = joueur.spriteMoto.x - joueur.lastWallPosition
        console.log joueur.lastWall.width
      else if joueur.spriteMoto.body.velocity.x < 0 # si on se deplace vers la gauche
        joueur.lastWall.width = joueur.lastWallPosition - (joueur.spriteMoto.x + joueur.spriteMoto.width)
      else if joueur.spriteMoto.body.velocity.y > 0 # si on se deplace vers le bas
        joueur.lastWall.height = joueur.spriteMoto.y - joueur.lastWall.y
      else if joueur.spriteMoto.body.velocity.y < 0 # si on se deplace vers le haut
        joueur.lastWall.height = joueur.lastWallPosition - (joueur.spriteMoto.y + joueur.lastWall.y)



  moveUp: (joueur, bmd) ->
    joueur.spriteMoto.body.velocity.y = -@globalVelocity
    joueur.spriteMoto.body.velocity.x = 0

    bmd.ctx.rect(0,0,@epaisseurMur,5)
    bmd.ctx.fill()
    joueur.lastWall = game.add.sprite(joueur.spriteMoto.x + joueur.spriteMoto.width/2, joueur.spriteMoto.y + joueur.spriteMoto.height, bmd)
    game.physics.arcade.enable([joueur.lastWall]);
    joueur.lastWall.body.velocity.y = -@globalVelocity
    joueur.lastWallPosition = joueur.spriteMoto.y + joueur.spriteMoto.height

  moveDown: (joueur, bmd) ->
    joueur.spriteMoto.body.velocity.y = @globalVelocity
    joueur.spriteMoto.body.velocity.x = 0

    bmd.ctx.rect(0,0,@epaisseurMur,5)
    bmd.ctx.fill()
    joueur.lastWall = game.add.sprite(joueur.spriteMoto.x + joueur.spriteMoto.width/2, joueur.spriteMoto.y, bmd)
    joueur.lastWallPosition = joueur.spriteMoto.y

  moveLeft: (joueur, bmd) ->
    joueur.spriteMoto.body.velocity.x = -@globalVelocity
    joueur.spriteMoto.body.velocity.y = 0

    bmd.ctx.rect(0,0, 5 ,@epaisseurMur)
    bmd.ctx.fill()
    joueur.lastWall = game.add.sprite(joueur.spriteMoto.x + joueur.spriteMoto.width, joueur.spriteMoto.y + joueur.spriteMoto.width/2, bmd)
    game.physics.arcade.enable([joueur.lastWall]);
    joueur.lastWall.body.velocity.x = -@globalVelocity
    joueur.lastWallPosition = joueur.spriteMoto.x + joueur.spriteMoto.width

  moveRight: (joueur, bmd) ->
    joueur.spriteMoto.body.velocity.x = @globalVelocity
    joueur.spriteMoto.body.velocity.y = 0

    bmd.ctx.rect(0,0, 5 ,@epaisseurMur)
    bmd.ctx.fill()
    joueur.lastWall = game.add.sprite(joueur.spriteMoto.x, joueur.spriteMoto.y + joueur.spriteMoto.width/2, bmd)
    joueur.lastWallPosition = joueur.spriteMoto.x




  tourneDroite: (joueur, bmd) ->
    if joueur.spriteMoto.body.velocity.x > 0
      @moveDown joueur, bmd

    else if joueur.spriteMoto.body.velocity.x < 0
      @moveUp joueur, bmd

    else if joueur.spriteMoto.body.velocity.y > 0
      @moveLeft joueur, bmd

    else if joueur.spriteMoto.body.velocity.y < 0
      @moveRight joueur, bmd

    console.log 'tourne droite' if debug

  tourneGauche: (joueur, bmd) ->
    if joueur.spriteMoto.body.velocity.x > 0
      @moveUp joueur, bmd

    else if joueur.spriteMoto.body.velocity.x < 0
      @moveDown joueur, bmd

    else if joueur.spriteMoto.body.velocity.y > 0
      @moveRight joueur, bmd

    else if joueur.spriteMoto.body.velocity.y < 0
      @moveLeft joueur, bmd

    console.log 'tourne gauche' if debug

  tourne: (joueur, direction) ->
    joueur.lastWall.body.moves = false if joueur.lastWall && joueur.lastWall.body
    joueur.bmd = game.add.bitmapData()
    joueur.bmd.ctx.beginPath()
    joueur.bmd.ctx.fillStyle = '#ff0000'

    if direction == "droite"
      @tourneDroite joueur, joueur.bmd

    else if direction == "gauche"
      @tourneGauche joueur, joueur.bmd

  constructor: (@game) ->
    console.log 'GamePlay::construct()' if debug
    #@moteur = new tronEngine(500,500)

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

    game.time.advancedTiming = true
    game.stage.smoothed = false

    @joueur1.spriteMoto = game.add.sprite(50, 50, 'moto1');

    #game.physics.startSystem(Phaser.Physics.ARCADE);
    game.physics.arcade.enable([@joueur1.spriteMoto]);

    @joueur1.spriteMoto.body.velocity.y = @globalVelocity
    @tourne @joueur1, "gauche"
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
    @tourne @joueur1, "gauche"

  listenerBoutonD: () ->
    console.log "bonton droit" if debug
    @tourne @joueur1, "droite"

  update: ->

    console.log 'GamePlay::update()' if debug


    @prolongerMur @joueur1


#@moteur.nextStep()


    #@spriteMoto1.body.velocity.x = @moteur.player1.getVelocityX()
    #@spriteMoto1.body.velocity.y = @moteur.player1.getVelocityY()

    #@spriteMoto1.position(@moteur.player1.posX, @moteur.player1.posY)






