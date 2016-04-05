class GamePlay

  # sprites des joueurs
  joueurs: []

  # sprites des deux boutons
  spriteG: null
  spriteD: null

  bmd: null

  globalVelocity: 100 # vitesse des motos
  epaisseurMur : 10

  nbJoueur : 1
  nbMort: 0

  couleursJ: []


  tourne: (joueur, direction) ->
    if direction == "droite"
      joueur.angle += 90
    else if direction == "gauche"
      joueur.angle -= 90;

    game.physics.arcade.velocityFromAngle(joueur.angle, @globalVelocity, joueur.body.velocity);


  collisionTest: (joueur) ->


    if joueur.x < 0 || joueur.x > game.width || joueur.y < 0 || joueur.y > game.height
      console.log "lol"
      @explode(joueur)


    for i in [(-@epaisseurMur/2)-1, (@epaisseurMur/2)-1]
      posTempX = joueur.x
      posTempY = joueur.y

      if joueur.body.velocity.x > 1
        posTempX += joueur.width/2+2
        posTempY += i
      else if joueur.body.velocity.x < -1
        posTempX -= joueur.width/2 +2
        posTempY += i
      else if joueur.body.velocity.y > 1
        posTempY += joueur.height/2+2
        posTempX += i
      else
        posTempY -= joueur.height/2 + 2
        posTempX += i

      retour = @bmd.getPixel Math.round(posTempX), Math.round(posTempY)

      if retour.a != 0
        @explode joueur
        break

  explode: (joueur) ->
    console.log "boum!" if debug
    @nbMort++
    joueur.kill()

  constructor: (@game) ->
    console.log 'GamePlay::construct()' if debug

  init: (nbJoueur) ->
    @nbJoueur = nbJoueur

  preload: ->
    console.log 'GamePlay::preload()' if debug
    game.load.image 'fleche_gauche', 'assets/fleche_gauche.png'
    game.load.image 'fleche_droite', 'assets/fleche_droite.png'


  create: ->
    console.log 'GamePlay::create()' if debug


    # initialisation de la physique
    game.physics.startSystem Phaser.Physics.ARCADE

    #couleur de fond
    game.stage.backgroundColor = '#124184';

    @nbJoueur = 4

    @couleursJ = new Array(4)

    @couleursJ[0] = '#00ff00'
    @couleursJ[1] = '#00ffff'
    @couleursJ[2] = '#ff00ff'
    @couleursJ[3] = '#ffff00'


    for i in [0..@nbJoueur-1]
      @joueurs.push game.add.sprite(0, 0, null) # on ne sprite pas le sprite x)

      @joueurs[i].width = @epaisseurMur
      @joueurs[i].height = @epaisseurMur

      # on active la physique pour le joueur
      game.physics.arcade.enable @joueurs[i], Phaser.Physics.ARCADE
      @joueurs[i].body.velocity.x = @globalVelocity

      # permet de positionner les positions au centre du sprite
      @joueurs[i].anchor.set(0.5)


    if @nbJoueur == 1
      @joueurs[0].x = game.width/4
      @joueurs[0].y = game.height/4
      @joueurs[0].angle = 90


    else if @nbJoueur == 2
      @joueurs[0].x = game.width/4
      @joueurs[0].y = game.height/4
      @joueurs[0].angle = 90

      @joueurs[1].x = 3*game.width/4
      @joueurs[1].y = 3*game.height/4
      @joueurs[1].angle = -90

    else if @nbJoueur == 3
      @joueurs[0].x = game.width/4
      @joueurs[0].y = game.height/4
      @joueurs[0].angle = 90

      @joueurs[1].x = 3*game.width/4
      @joueurs[1].y = game.height/4
      @joueurs[1].angle = 180

      @joueurs[2].x = game.width/2
      @joueurs[2].y = 3*game.height/4

    else if @nbJoueur == 4
      @joueurs[0].x = game.width/4
      @joueurs[0].y = game.height/4
      @joueurs[0].angle = 90

      @joueurs[1].x = 3*game.width/4
      @joueurs[1].y = game.height/4
      @joueurs[1].angle = 180

      @joueurs[2].x = game.width/4
      @joueurs[2].y = 3*game.height/4

      @joueurs[3].x = 3*game.width/4
      @joueurs[3].y = 3*game.height/4
      @joueurs[3].angle = -90

    for i in [0..@nbJoueur-1]
      game.physics.arcade.velocityFromAngle(@joueurs[i].angle, @globalVelocity, @joueurs[i].body.velocity);


    # bitMap qui sers à dessiner les murs
    @bmd = game.add.bitmapData(game.width, game.height)
    bg = game.add.sprite(0, 0, @bmd);







    # ici on gere les deux boutons
    #d'abord on crée les sprites
    @spriteG = game.add.sprite(0, 0, 'fleche_gauche');
    @spriteG.scale.setTo(0.2, 0.2);

    @spriteD = game.add.sprite(50, 0, 'fleche_droite');
    @spriteD.scale.setTo(0.2, 0.2);

    #ensuite on active les actions aux inputs
    @spriteG.inputEnabled = true;
    @spriteG.events.onInputDown.add(@listenerBoutonG1, this);

    @spriteD.inputEnabled = true;
    @spriteD.events.onInputDown.add(@listenerBoutonD1, this);




  listenerBoutonG1: () ->
    console.log "bonton gauche" if debug
    @tourne @joueurs[0], "gauche"

  listenerBoutonD1: () ->
    console.log "bonton droit" if debug
    @tourne @joueurs[0], "droite"

  update: ->
    console.log 'GamePlay::update()' if debug

    if @nbMort < @nbJoueur
      @bmd.update()
      for i in [0..@nbJoueur-1]
        if @joueurs[i].alive
          positionX = @joueurs[i].x - @epaisseurMur/2
          positionY = @joueurs[i].y - @epaisseurMur/2

          @bmd.context.fillStyle = @couleursJ[i]
          @bmd.ctx.fill()

          @collisionTest @joueurs[i]

          @bmd.context.fillRect(positionX, positionY, @epaisseurMur, @epaisseurMur)
          @bmd.dirty = true