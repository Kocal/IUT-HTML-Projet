create = () ->
    console.log "create"

    game.scale.fullScreenScaleMode = Phaser.ScaleManager.EXACT_FIT;
    game.input.onDown.add toggleFullScreen, this

    spriteG = game.add.sprite 0, 0, 'fleche_gauche'
    spriteG.scale.setTo 0.2, 0.2
    spriteD = game.add.sprite 50, 0, 'fleche_droite'
    spriteD.scale.setTo 0.2, 0.2


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

toggleFullScreen = ->
    if game.scale.isFullScreen
        game.scale.stopFullScreen()
    else
        game.scale.startFullScreen false

