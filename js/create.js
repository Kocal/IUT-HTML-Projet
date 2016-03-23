// Generated by CoffeeScript 1.10.0
var create, listenerBoutonD, listenerBoutonG, toggleFullScreen;

create = function() {
  var moteur, spriteD, spriteG;
  console.log("create");
  game.scale.fullScreenScaleMode = Phaser.ScaleManager.EXACT_FIT;
  game.input.onDown.add(toggleFullScreen, this);
  spriteG = game.add.sprite(0, 0, 'fleche_gauche');
  spriteG.scale.setTo(0.2, 0.2);
  spriteD = game.add.sprite(50, 0, 'fleche_droite');
  spriteD.scale.setTo(0.2, 0.2);
  moteur = new tronEngine();
  spriteG.inputEnabled = true;
  spriteG.events.onInputDown.add(listenerBoutonG, this);
  spriteD.inputEnabled = true;
  return spriteD.events.onInputDown.add(listenerBoutonD, this);
};

listenerBoutonG = function() {
  return console.log("bonton gauche");
};

listenerBoutonD = function() {
  return console.log("bonton droit");
};

toggleFullScreen = function() {
  if (game.scale.isFullScreen) {
    return game.scale.stopFullScreen();
  } else {
    return game.scale.startFullScreen(false);
  }
};

//# sourceMappingURL=create.js.map
