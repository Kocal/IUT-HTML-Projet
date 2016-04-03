class GamePlay

  # sprites des joueurs
  joueur1: null
  joueur2: null
  joueur3: null
  joueur4: null

  # sprites des deux boutons
  spriteG: null
  spriteD: null

  bmd: null

  globalVelocity: 100 # vitesse des motos
  epaisseurMur : 10
  epaisseurMoto: 1


  tourne: (joueur, direction) ->
    if direction == "droite"
      joueur.angle += 90
    else if direction == "gauche"
      joueur.angle -= 90;
    game.physics.arcade.velocityFromAngle(joueur.angle, @globalVelocity, joueur.body.velocity);


  collisionTest: (joueur, positionX, positionY) ->



    @bmd.update()
    difference = 3
    combien = 0
    for i in [0..@epaisseurMur-1]
      posTempX = positionX
      posTempY = positionY

      if joueur.body.velocity.x == @globalVelocity
        posTempX += @epaisseurMur + difference
        posTempY += i
      else if joueur.body.velocity.x == -@globalVelocity
        posTempX -= difference
        posTempY += i
      else if joueur.body.velocity.y == @globalVelocity
        posTempY += @epaisseurMur + difference
        posTempX += i
      else
        posTempY -= difference
        posTempX += i

      retour = @bmd.getPixel posTempX, posTempY

      if retour.r || retour.g || retour.b
        combien++

    # en gros si 1/5 eme de la moto touche un mur..
    if combien > (@epaisseurMur/5)
      @explode(joueur)


  explode: (joueur) ->
    console.log "boum!" if debug
    joueur.kill()

  constructor: (@game) ->
    console.log 'GamePlay::construct()' if debug

  preload: ->
    console.log 'GamePlay::preload()' if debug
    game.load.image 'fleche_gauche', 'assets/fleche_gauche.png'
    game.load.image 'fleche_droite', 'assets/fleche_droite.png'


  create: ->
    console.log 'GamePlay::create()' if debug

    @epaisseurMoto *= @epaisseurMur

    # initialisation de la physique
    game.physics.startSystem Phaser.Physics.ARCADE

    #couleur de fond
    game.stage.backgroundColor = '#124184';

    # on genere le joueur 1, un sprite rouge degueu
    bmd = game.add.bitmapData(@epaisseurMoto,@epaisseurMoto);
    bmd.ctx.beginPath()
    bmd.ctx.rect(0,0,@epaisseurMoto,@epaisseurMoto)
    bmd.ctx.fillStyle = '#ff0000'
    bmd.ctx.fill()
    @joueur1 = game.add.sprite(200, 200, bmd)


    # bitMap qui sers à dessiner les murs
    @bmd = game.add.bitmapData(game.width, game.height)
    @bmd.context.fillStyle = '#ffffff'
    @bmd.ctx.fill()
    bg = game.add.sprite(0, 0, @bmd);


    # on active la physique pour le joueur1
    game.physics.arcade.enable @joueur1, Phaser.Physics.ARCADE
    @joueur1.body.velocity.x = @globalVelocity


    # permet de positionner les positions au centre du sprite
    @joueur1.anchor.set(0.5)



    # ici on gere les deux boutons
    #d'abord on crée les sprites
    @spriteG = game.add.sprite(0, 0, 'fleche_gauche');
    @spriteG.scale.setTo(0.2, 0.2);

    @spriteD = game.add.sprite(50, 0, 'fleche_droite');
    @spriteD.scale.setTo(0.2, 0.2);

    #ensuite on active les actions aux inputs
    @spriteG.inputEnabled = true;
    @spriteG.events.onInputDown.add(@listenerBoutonG, this);

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


    positionX = @joueur1.x - @epaisseurMur/2
    positionY = @joueur1.y - @epaisseurMur/2


    if @joueur1.alive
      @collisionTest @joueur1, positionX, positionY

    @bmd.context.fillRect(positionX, positionY, @epaisseurMur, @epaisseurMur)
    @bmd.dirty = true
