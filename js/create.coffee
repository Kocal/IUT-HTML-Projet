buttons =
    play: null
    player1_left: null
    player1_right: null
    player2_left: null
    player2_right: null

boundings =
    play:
        height: 0
        width: 0
    arrows:
        height: 0
        width: 0
    game:
        height: 0
        width: 0

create = ->
    console.log 'Create'

    game.scale.fullScreenScaleMode = Phaser.ScaleManager.EXACT_FIT;
    #game.input.onDown.add toggleFullScreen, this

    #if(isSmallScreen())
    #    toggleFullScreen()

    updateBoundings()
    initButtonPlay()

initButtonPlay = ->
    #buttons.play = game.add.button

isSmallScreen = ->
    return window.innerHeight < 768;

toggleFullScreen = ->
    if game.scale.isFullScreen
        game.scale.stopFullScreen()
    else
        game.scale.startFullScreen false

updateBoundings = ->

