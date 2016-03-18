boundings =
    arrows:
        height: 0
        width: 0
    game:
        height: 0
        width: 0

create = ->
    console.log 'Create'

    game.scale.fullScreenScaleMode = Phaser.ScaleManager.EXACT_FIT;
    game.input.onDown.add toggleFullScreen, this

    updateBoundings()

toggleFullScreen = ->
    if game.scale.isFullScreen
        game.scale.stopFullScreen()
    else
        game.scale.startFullScreen false

updateBoundings = ->
    
