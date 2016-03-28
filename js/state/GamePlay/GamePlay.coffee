class GamePlay

  # pour grouper le sprite, le dernier mur, etc
  class Joueur
    spriteMoto: null
    lastWall : null
    lastWallPosition: null # tres utile pour determiner la longueur du mur
    color : '#ff0000' # on devrais pourvoir modifier ceci de dehors mais ca fais buguer la generation des sprites des murs. En gros ca s'affiche plus...


  # du coup on crée les instances
  joueur1: Joueur
  joueur2: Joueur
  joueur3: Joueur
  joueur4: Joueur

  # sprites des deux boutons
  spriteG: null
  spriteD: null


  globalVelocity: 100 # vitesse des motos
  epaisseurMur: 10 # explicite

  listeSpriteMur: [] # truc qui contiendra notre groupe de mur

  # on étire le dernier mur du joueur
  prolongerMur : (joueur) ->
    if joueur.lastWall

      if joueur.spriteMoto.body.velocity.x > 0 # si on se deplace vers la droite
        joueur.lastWall.width = joueur.spriteMoto.x - joueur.lastWallPosition

      else if joueur.spriteMoto.body.velocity.x < 0 # si on se deplace vers la gauche
        joueur.lastWall.width = joueur.lastWallPosition - (joueur.spriteMoto.x + joueur.spriteMoto.width)

      else if joueur.spriteMoto.body.velocity.y > 0 # si on se deplace vers le bas
        joueur.lastWall.height = joueur.spriteMoto.y - joueur.lastWall.y

      else if joueur.spriteMoto.body.velocity.y < 0 # si on se deplace vers le haut
        joueur.lastWall.height = joueur.lastWallPosition - (joueur.spriteMoto.y + joueur.spriteMoto.height)



  # on fais bouger la velocité et on crée un nouveau sprite pour le nouveau mur
  # on l'enregistre dans joueur.lastWall pour pouvoir y avoir acces et pour l'étirer facilement
  moveUp: (joueur, bmd) ->
    # on fais tourner la moto
    joueur.spriteMoto.body.velocity.y = -@globalVelocity
    joueur.spriteMoto.body.velocity.x = 0

    # on crée un truc temporaire pour créer le sprite rectangulaire coloré
    bmd.ctx.rect(0,0,@epaisseurMur,1000)
    bmd.ctx.fill()

    # on ajoute un sprite au groupe de mur
    joueur.lastWall = @listeSpriteMur.create(joueur.spriteMoto.x + joueur.spriteMoto.width/2 - @epaisseurMur/2, joueur.spriteMoto.y + joueur.spriteMoto.height, bmd)

    # on lui active la physique
    game.physics.enable( joueur.lastWall , Phaser.Physics.ARCADE);

    # dans certains cas on lui donne une velocité, pour que le mur suive la moto tout seul comme un grand
    joueur.lastWall.body.velocity.y = -@globalVelocity
    joueur.lastWallPosition = joueur.lastWall.y

  # meme chose pour les autres
  moveDown: (joueur, bmd) ->
    joueur.spriteMoto.body.velocity.y = @globalVelocity
    joueur.spriteMoto.body.velocity.x = 0

    bmd.ctx.rect(0,0,@epaisseurMur,1000)
    bmd.ctx.fill()
    joueur.lastWall = @listeSpriteMur.create(joueur.spriteMoto.x + joueur.spriteMoto.width/2 - @epaisseurMur/2, joueur.spriteMoto.y, bmd)
    game.physics.enable( joueur.lastWall , Phaser.Physics.ARCADE);
    joueur.lastWallPosition = joueur.lastWall.y

  moveLeft: (joueur, bmd) ->
    joueur.spriteMoto.body.velocity.x = -@globalVelocity
    joueur.spriteMoto.body.velocity.y = 0

    bmd.ctx.rect(0,0, 1000,@epaisseurMur)
    bmd.ctx.fill()
    joueur.lastWall = @listeSpriteMur.create(joueur.spriteMoto.x + joueur.spriteMoto.width, joueur.spriteMoto.y + joueur.spriteMoto.width/2 - @epaisseurMur/2, bmd)
    game.physics.enable( joueur.lastWall , Phaser.Physics.ARCADE);
    joueur.lastWall.body.velocity.x = -@globalVelocity
    joueur.lastWallPosition = joueur.lastWall.x

  moveRight: (joueur, bmd) ->
    joueur.spriteMoto.body.velocity.x = @globalVelocity
    joueur.spriteMoto.body.velocity.y = 0

    bmd.ctx.rect(0,0, 1000,@epaisseurMur)
    bmd.ctx.fill()
    joueur.lastWall = @listeSpriteMur.create(joueur.spriteMoto.x, joueur.spriteMoto.y + joueur.spriteMoto.width/2 - @epaisseurMur/2, bmd)
    game.physics.enable( joueur.lastWall , Phaser.Physics.ARCADE);
    joueur.lastWallPosition = joueur.lastWall.x




  # on fais evoluer la vélocité en fonction de la direction de la fleche
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
    # bmd c'est le truc pour créer un sprite coloré rectangulaire basique
    # on le fais ici pour éviter la repetition de code dans tourneDroite et tourneGauche
    joueur.lastWall.body.moves = false if joueur.lastWall && joueur.lastWall.body
    joueur.bmd = game.add.bitmapData()
    joueur.bmd.ctx.beginPath()
    joueur.bmd.ctx.fillStyle = '#ff0000'

    if direction == "droite"
      @tourneDroite joueur, joueur.bmd

    else if direction == "gauche"
      @tourneGauche joueur, joueur.bmd


  verifCollide: (player, wall) ->
    # on cherche à savoir si la moto ne serais pas en train de réagir avec son dernier mur
    if player == @joueur1.spriteMoto
      if wall != @joueur1.lastWall
        true
      else
        false

  explode: () ->
    console.log "boum!"

  constructor: (@game) ->
    console.log 'GamePlay::construct()' if debug

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

    # on genere le joueur un, un sprite bleu degueu
    bmd = game.add.bitmapData()
    bmd.ctx.beginPath()
    bmd.ctx.fillStyle = '#0000FF'
    bmd.ctx.rect(0,0,1000,1000)
    bmd.ctx.fill()

    @joueur1.spriteMoto = game.add.sprite(50, 50, bmd)
    @joueur1.spriteMoto.width = @epaisseurMur
    @joueur1.spriteMoto.height = @epaisseurMur


    # on crée le groupe de sprite qui contiendra nos murs
    @listeSpriteMur = game.add.group()

    # initialisation de la physique
    game.physics.startSystem Phaser.Physics.ARCADE

    # on actuve la physique pour le joueur1
    game.physics.arcade.enable @joueur1.spriteMoto

    # on donne une vitesse et on le fais tourner
    # dans le but d'initialiser le départ "proprement"
    @joueur1.spriteMoto.body.velocity.y = @globalVelocity
    @tourne @joueur1, "gauche"

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


  # kekispasse quand on clique
  listenerBoutonG: () ->
    console.log "bonton gauche" if debug
    @tourne @joueur1, "gauche"

  listenerBoutonD: () ->
    console.log "bonton droit" if debug
    @tourne @joueur1, "droite"

  update: ->
    console.log 'GamePlay::update()' if debug

    @prolongerMur @joueur1

    # test des collisions $joueur1 avec tous les murs
    # explode c'est la fonction appelé si il y a collision
    # verifCollide c'est pour faire un pré test et voir si on ne réagirais pas avec le dernier mur, collé au cul...
    # ca foire, ca triger tout seul, ca fais chier
    game.physics.arcade.collide @joueur1.spriteMoto, @listeSpriteMur, @explode, @verifCollide, this