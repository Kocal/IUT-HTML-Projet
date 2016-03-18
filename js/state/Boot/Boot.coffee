class Boot
    constructor: (@game) ->
        console.log "Boot::constructor()" if debug

    preload: ->
        console.log "Boot::preload()" if debug

    create: ->
        console.log "Boot::create()" if debug
        @game.scale.fullScreenScaleMode = Phaser.ScaleManager.EXACT_FIT
        @game.state.start "GamePlay"
