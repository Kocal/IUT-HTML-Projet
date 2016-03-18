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

    updateBoundings()
    initButtonPlay()

initButtonPlay = ->
    buttons.play = game.add.button 100, 100, 'Jouer', play, this, 2, 1, 0

play = ->
    console.log "jouer !";
    toggleFullScreen()

isSmallScreen = ->
    return window.innerHeight < 768;

toggleFullScreen = ->
    if game.scale.isFullScreen
        game.scale.stopFullScreen()
    else
        game.scale.startFullScreen false

updateBoundings = ->

