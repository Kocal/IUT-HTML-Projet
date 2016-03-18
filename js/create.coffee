create = ->
    console.log 'Create'

    game.scale.fullScreenScaleMode = Phaser.ScaleManager.EXACT_FIT;
    game.input.onDown.add toggleFullScreen, this

toggleFullScreen = ->
    if game.scale.isFullScreen
        game.scale.stopFullScreen()
    else
        game.scale.startFullScreen false
