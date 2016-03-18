create = () ->
    console.log "create"
    spriteG = game.add.sprite 0, 0, 'fleche_gauche'
    spriteG.scale.setTo 0.2, 0.2
    spriteD = game.add.sprite 50, 0, 'fleche_droite'
    spriteD.scale.setTo 0.2, 0.2

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