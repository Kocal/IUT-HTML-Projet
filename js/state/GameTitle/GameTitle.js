// Generated by CoffeeScript 1.10.0
var GameTitle;

GameTitle = (function() {
  function GameTitle(game) {
    this.game = game;
    if (debug) {
      console.log('GameTitle::constructor()');
    }
  }

  GameTitle.prototype.preload = function() {
    if (debug) {
      console.log('GameTitle::preload()');
    }
    this.game.load.image('logo', '/assets/img/logo.png');
    this.game.load.image('buttonPlay', '/assets/img/buttonPlay.png');
    this.game.load.image('orangeTrace', '/assets/img/orangeTrace.png');
    this.game.load.image('blueTrace', '/assets/img/blueTrace.png');
  };

  GameTitle.prototype.create = function() {
    var i, j;
    if (debug) {
      console.log('GameTitle::create()');
    }
    this.texture = this.game.add.renderTexture(this.game.world.width, this.game.world.height, 'mousetrail');
    this.game.add.sprite(0, 0, this.texture);
    this.traces = this.game.make.group();
    for (i = j = 0; j <= 10; i = ++j) {
      this.traces.add(this._initATrace());
    }
    this.sLogo = this.game.add.sprite(this.game.world.centerX, this.game.world.centerY, 'logo');
    this.sLogo.anchor.setTo(0.5, 1);
    this.sButtonPlay = this.game.add.button(this.game.world.centerX, this.sLogo.y, 'buttonPlay', this.onButtonPlayClick, this, 0, 1, 2);
    this.sButtonPlay.anchor.setTo(0.5, -1);
  };

  GameTitle.prototype.update = function() {
    var j, len, ref, trace;
    if (debug) {
      console.log('GameTitle::update()');
    }
    ref = this.traces.children;
    for (j = 0, len = ref.length; j < len; j++) {
      trace = ref[j];
      this.texture.renderXY(trace, trace.x, trace.y);
      if (trace.x >= this.game.width || trace.y >= this.game.height) {
        trace.x = Math.random() * this.game.width;
        trace.y = 0;
      }
    }
  };

  GameTitle.prototype.onButtonPlayClick = function() {
    console.log('Jouer');
    this.game.state.start('GamePlay');
  };

  GameTitle.prototype._initATrace = function() {
    var isOrange, trace, velocity, x, y;
    isOrange = Math.random() >= 0.5;
    velocity = Math.random() * 50 + 10;
    x = Math.random() * this.game.width;
    y = 0;
    trace = this.game.make.sprite(x, y, isOrange ? 'orangeTrace' : 'blueTrace');
    this.game.physics.enable(trace, Phaser.Physics.ARCADE);
    trace.anchor.setTo(0.5);
    trace.body.velocity.y = velocity;
    return trace;
  };

  return GameTitle;

})();

//# sourceMappingURL=GameTitle.js.map
