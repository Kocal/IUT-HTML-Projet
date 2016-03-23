class GamePlay

  constructor: (@game) ->
    console.log 'GamePlay::construct()' if debug

  preload: ->
    console.log 'GamePlay::preload()' if debug
    game.load.image 'fleche_gauche', 'assets/fleche_gauche.png'
    game.load.image 'fleche_droite', 'assets/fleche_droite.png'

  create: ->
    console.log 'GamePlay::create()' if debug

    moteur = new tronEngine()

    #  Enables all kind of input actions on this image (click, etc)
    spriteG.inputEnabled = true;
    spriteG.events.onInputDown.add(listenerBoutonG, this);

    #  Enables all kind of input actions on this image (click, etc)
    spriteD.inputEnabled = true;
    spriteD.events.onInputDown.add(listenerBoutonD, this);

listenerBoutonG = () ->
  console.log "bonton gauche"

listenerBoutonD = () ->
  console.log "bonton droit"

  update: ->
    console.log 'GamePlay::update()' if debug

    spriteG = game.add.sprite 0, 0, 'fleche_gauche'
    spriteG.scale.setTo 0.2, 0.2
    spriteD = game.add.sprite 50, 0, 'fleche_droite'
    spriteD.scale.setTo 0.2, 0.2
        
