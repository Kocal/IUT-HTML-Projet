class GamePlay

  # sprites des joueurs
  joueurs: []


  bmd: null

  globalVelocity: 100 # vitesse des motos
  epaisseurMur : 10

  nbJoueur : 1
  nbMort: 0

  modeDeJeu: "pc"

  couleursJ: []

  tickRefresh: 5
  tick: 0

  tourne: (joueur, direction) ->
    if direction == "droite"
      joueur.angle += 90
    else if direction == "gauche"
      joueur.angle -= 90;

    game.physics.arcade.velocityFromAngle(joueur.angle, @globalVelocity, joueur.body.velocity);

  collisionTest: (joueur) ->
    if joueur.x < 0 || joueur.x > game.width || joueur.y < 0 || joueur.y > game.height
      @explode(joueur)


    for i in [-@epaisseurMur/2, @epaisseurMur/2]
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
    game.load.image 'fleche_gauche1', 'assets/fleche_gauche1.png'
    game.load.image 'fleche_droite1', 'assets/fleche_droite1.png'

    game.load.image 'fleche_gauche2', 'assets/fleche_gauche2.png'
    game.load.image 'fleche_droite2', 'assets/fleche_droite2.png'

    game.load.image 'fleche_gauche3', 'assets/fleche_gauche3.png'
    game.load.image 'fleche_droite3', 'assets/fleche_droite3.png'

    game.load.image 'fleche_gauche4', 'assets/fleche_gauche4.png'
    game.load.image 'fleche_droite4', 'assets/fleche_droite4.png'


  create: ->
    console.log 'GamePlay::create()' if debug


    # initialisation de la physique
    game.physics.startSystem Phaser.Physics.ARCADE

    #couleur de fond
    game.stage.backgroundColor = '#124184'

    @nbMort = 0
    @nbJoueur = 4

    @couleursJ = new Array(4)

    @couleursJ[0] = '#00ff00'
    @couleursJ[1] = '#00ffff'
    @couleursJ[2] = '#ff00ff'
    @couleursJ[3] = '#ffff00'


    if @joueurs
      @joueurs = []

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


    @tickRefresh = 5


    # les controles seront responsive
    # au format pc, des touches controleront les motos
    # au format smartphone, des boutons le feront
    if game.width < 600

      @tickRefresh *= 2

      @modeDeJeu = "mobile"
      # format bouton

      # ici on gere les deux boutons
      #d'abord on crée les sprites

      spriteG = game.add.sprite(0, 0, 'fleche_gauche1')
      spriteG.scale.setTo(0.2, 0.2)

      spriteD = game.add.sprite(50, 0, 'fleche_droite1')
      spriteD.scale.setTo(0.2, 0.2)

      #ensuite on active les actions aux inputs
      spriteG.inputEnabled = true
      spriteG.events.onInputDown.add(@listenerBoutonG1, this)

      spriteD.inputEnabled = true
      spriteD.events.onInputDown.add(@listenerBoutonD1, this)

      if @nbJoueur >= 2
        spriteG = game.add.sprite(0, 0, 'fleche_gauche2')
        spriteG.scale.setTo(0.2, 0.2)
        spriteG.x = game.width - (spriteG.width*2)

        spriteD = game.add.sprite(50, 0, 'fleche_droite2')
        spriteD.scale.setTo(0.2, 0.2)
        spriteD.x = game.width - spriteG.width

        #ensuite on active les actions aux inputs
        spriteG.inputEnabled = true
        spriteG.events.onInputDown.add(@listenerBoutonG2, this)

        spriteD.inputEnabled = true
        spriteD.events.onInputDown.add(@listenerBoutonD2, this)

        if @nbJoueur >= 3
          spriteG = game.add.sprite(0, 0, 'fleche_gauche3')
          spriteG.scale.setTo(0.2, 0.2)
          spriteG.y = game.height - spriteG.height

          spriteD = game.add.sprite(50, 0, 'fleche_droite3')
          spriteD.scale.setTo(0.2, 0.2)
          spriteD.y = game.height - spriteG.height

          #ensuite on active les actions aux inputs
          spriteG.inputEnabled = true
          spriteG.events.onInputDown.add(@listenerBoutonG3, this)

          spriteD.inputEnabled = true
          spriteD.events.onInputDown.add(@listenerBoutonD3, this)

          if @nbJoueur == 4
            spriteG = game.add.sprite(0, 0, 'fleche_gauche4')
            spriteG.scale.setTo(0.2, 0.2)
            spriteG.x = game.width - (spriteG.width*2)
            spriteG.y = game.height - spriteG.height

            spriteD = game.add.sprite(50, 0, 'fleche_droite4')
            spriteD.scale.setTo(0.2, 0.2)
            spriteD.x = game.width - spriteG.width
            spriteD.y = game.height - spriteG.height

            #ensuite on active les actions aux inputs
            spriteG.inputEnabled = true
            spriteG.events.onInputDown.add(@listenerBoutonG4, this)

            spriteD.inputEnabled = true
            spriteD.events.onInputDown.add(@listenerBoutonD4, this)




    else
      btG = this.input.keyboard.addKey(Phaser.Keyboard.A)
      btG.onDown.add(@listenerBoutonG1, this)

      btD = this.input.keyboard.addKey(Phaser.Keyboard.Z)
      btD.onDown.add(@listenerBoutonD1, this)

      if @nbJoueur >= 2
        btG = this.input.keyboard.addKey(Phaser.Keyboard.T)
        btG.onDown.add(@listenerBoutonG2, this)

        btD = this.input.keyboard.addKey(Phaser.Keyboard.Y)
        btD.onDown.add(@listenerBoutonD2, this)

        if @nbJoueur >= 3
          btG = this.input.keyboard.addKey(Phaser.Keyboard.O)
          btG.onDown.add(@listenerBoutonG3, this)

          btD = this.input.keyboard.addKey(Phaser.Keyboard.P)
          btD.onDown.add(@listenerBoutonD3, this)

          if @nbJoueur == 4
            btG = this.input.keyboard.addKey(Phaser.Keyboard.LEFT)
            btG.onDown.add(@listenerBoutonG4, this)

            btD = this.input.keyboard.addKey(Phaser.Keyboard.RIGHT)
            btD.onDown.add(@listenerBoutonD4, this)


  listenerBoutonG1: () ->
    console.log "bonton gauche" if debug
    @tourne @joueurs[0], "gauche"

  listenerBoutonD1: () ->
    console.log "bonton droit" if debug
    @tourne @joueurs[0], "droite"

  listenerBoutonG2: () ->
    console.log "bonton gauche" if debug
    @tourne @joueurs[1], "gauche"

  listenerBoutonD2: () ->
    console.log "bonton droit" if debug
    @tourne @joueurs[1], "droite"

  listenerBoutonG3: () ->
    console.log "bonton gauche" if debug
    @tourne @joueurs[2], "gauche"

  listenerBoutonD3: () ->
    console.log "bonton droit" if debug
    @tourne @joueurs[2], "droite"

  listenerBoutonG4: () ->
    console.log "bonton gauche" if debug
    @tourne @joueurs[3], "gauche"

  listenerBoutonD4: () ->
    console.log "bonton droit" if debug
    @tourne @joueurs[3], "droite"

  winnerScreen: () ->
    console.log "bonjour"
    game.state.start(game.state.current, true, true, @nbJoueur)

  update: ->
    console.log 'GamePlay::update()' if debug


    @tick++
    if @tick >= @tickRefresh
      @tick=0
      @bmd.update()


    if @nbMort < @nbJoueur
      for i in [0..@nbJoueur-1]
        if @joueurs[i].alive
          positionX = @joueurs[i].x - @epaisseurMur/2
          positionY = @joueurs[i].y - @epaisseurMur/2

          @bmd.context.fillStyle = @couleursJ[i]
          @bmd.ctx.fill()

          @collisionTest @joueurs[i]

          @bmd.context.fillRect(positionX, positionY, @epaisseurMur, @epaisseurMur)
          @bmd.dirty = true
    else
      @winnerScreen()
