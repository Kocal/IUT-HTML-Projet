// Generated by CoffeeScript 1.10.0
var Boot;

Boot = (function() {
  function Boot(game) {
    this.game = game;
    if (debug) {
      console.log('Boot::constructor()');
    }
  }

  Boot.prototype.preload = function() {
    if (debug) {
      return console.log('Boot::preload()');
    }
  };

  Boot.prototype.create = function() {
    if (debug) {
      console.log('Boot::create()');
    }
    return this.game.state.start('GameTitle', true, true);
  };

  return Boot;

})();

//# sourceMappingURL=Boot.js.map
