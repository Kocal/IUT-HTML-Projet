// Generated by CoffeeScript 1.10.0
var GamePlay;

GamePlay = (function() {
  GamePlay.prototype.joueurs = [];

  GamePlay.prototype.spriteG = null;

  GamePlay.prototype.spriteD = null;

  GamePlay.prototype.bmd = null;

  GamePlay.prototype.globalVelocity = 100;

  GamePlay.prototype.epaisseurMur = 10;

  GamePlay.prototype.nbJoueur = 1;

  GamePlay.prototype.couleursJ = [];

  GamePlay.prototype.tourne = function(joueur, direction) {
    if (direction === "droite") {
      joueur.angle += 90;
    } else if (direction === "gauche") {
      joueur.angle -= 90;
    }
    return game.physics.arcade.velocityFromAngle(joueur.angle, this.globalVelocity, joueur.body.velocity);
  };

  GamePlay.prototype.collisionTest = function(joueur) {
    var posTempX, posTempY, retour;
    if (joueur.x < 0 || joueur.x > game.width || joueur.y < 0 || joueur.y > game.height) {
      console.log("lol");
      this.explode(joueur);
    }
    posTempX = joueur.x;
    posTempY = joueur.y;
    if (joueur.body.velocity.x > 1) {
      posTempX += joueur.width / 2 + 2;
    } else if (joueur.body.velocity.x < -1) {
      posTempX -= joueur.width / 2 + 2;
    } else if (joueur.body.velocity.y > 1) {
      posTempY += joueur.height / 2 + 2;
    } else {
      posTempY -= joueur.height / 2 + 2;
    }
    retour = this.bmd.getPixel(Math.round(posTempX), Math.round(posTempY));
    if (retour.a !== 0) {
      return this.explode(joueur);
    }
  };

  GamePlay.prototype.explode = function(joueur) {
    if (debug) {
      console.log("boum!");
    }
    return joueur.kill();
  };

  function GamePlay(game1) {
    this.game = game1;
    if (debug) {
      console.log('GamePlay::construct()');
    }
  }

  GamePlay.prototype.init = function(nbJoueur) {
    return this.nbJoueur = nbJoueur;
  };

  GamePlay.prototype.preload = function() {
    if (debug) {
      console.log('GamePlay::preload()');
    }
    game.load.image('fleche_gauche', 'assets/fleche_gauche.png');
    return game.load.image('fleche_droite', 'assets/fleche_droite.png');
  };

  GamePlay.prototype.create = function() {
    var bg, i, j, k, ref, ref1;
    if (debug) {
      console.log('GamePlay::create()');
    }
    game.physics.startSystem(Phaser.Physics.ARCADE);
    game.stage.backgroundColor = '#124184';
    this.nbJoueur = 4;
    this.couleursJ = new Array(4);
    this.couleursJ[0] = '#00ff00';
    this.couleursJ[1] = '#00ffff';
    this.couleursJ[2] = '#ff00ff';
    this.couleursJ[3] = '#ffff00';
    for (i = j = 0, ref = this.nbJoueur - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
      this.joueurs.push(game.add.sprite(0, 0, null));
      this.joueurs[i].width = this.epaisseurMur;
      this.joueurs[i].height = this.epaisseurMur;
      game.physics.arcade.enable(this.joueurs[i], Phaser.Physics.ARCADE);
      this.joueurs[i].body.velocity.x = this.globalVelocity;
      this.joueurs[i].anchor.set(0.5);
    }
    if (this.nbJoueur === 1) {
      this.joueurs[0].x = game.width / 4;
      this.joueurs[0].y = game.height / 4;
      this.joueurs[0].angle = 90;
    } else if (this.nbJoueur === 2) {
      this.joueurs[0].x = game.width / 4;
      this.joueurs[0].y = game.height / 4;
      this.joueurs[0].angle = 90;
      this.joueurs[1].x = 3 * game.width / 4;
      this.joueurs[1].y = 3 * game.height / 4;
      this.joueurs[1].angle = -90;
    } else if (this.nbJoueur === 3) {
      this.joueurs[0].x = game.width / 4;
      this.joueurs[0].y = game.height / 4;
      this.joueurs[0].angle = 90;
      this.joueurs[1].x = 3 * game.width / 4;
      this.joueurs[1].y = game.height / 4;
      this.joueurs[1].angle = 180;
      this.joueurs[2].x = game.width / 2;
      this.joueurs[2].y = 3 * game.height / 4;
    } else if (this.nbJoueur === 4) {
      this.joueurs[0].x = game.width / 4;
      this.joueurs[0].y = game.height / 4;
      this.joueurs[0].angle = 90;
      this.joueurs[1].x = 3 * game.width / 4;
      this.joueurs[1].y = game.height / 4;
      this.joueurs[1].angle = 180;
      this.joueurs[2].x = game.width / 4;
      this.joueurs[2].y = 3 * game.height / 4;
      this.joueurs[3].x = 3 * game.width / 4;
      this.joueurs[3].y = 3 * game.height / 4;
      this.joueurs[3].angle = -90;
    }
    for (i = k = 0, ref1 = this.nbJoueur - 1; 0 <= ref1 ? k <= ref1 : k >= ref1; i = 0 <= ref1 ? ++k : --k) {
      game.physics.arcade.velocityFromAngle(this.joueurs[i].angle, this.globalVelocity, this.joueurs[i].body.velocity);
    }
    this.bmd = game.add.bitmapData(game.width, game.height);
    bg = game.add.sprite(0, 0, this.bmd);
    this.spriteG = game.add.sprite(0, 0, 'fleche_gauche');
    this.spriteG.scale.setTo(0.2, 0.2);
    this.spriteD = game.add.sprite(50, 0, 'fleche_droite');
    this.spriteD.scale.setTo(0.2, 0.2);
    this.spriteG.inputEnabled = true;
    this.spriteG.events.onInputDown.add(this.listenerBoutonG1, this);
    this.spriteD.inputEnabled = true;
    return this.spriteD.events.onInputDown.add(this.listenerBoutonD1, this);
  };

  GamePlay.prototype.listenerBoutonG1 = function() {
    if (debug) {
      console.log("bonton gauche");
    }
    return this.tourne(this.joueurs[0], "gauche");
  };

  GamePlay.prototype.listenerBoutonD1 = function() {
    if (debug) {
      console.log("bonton droit");
    }
    return this.tourne(this.joueurs[0], "droite");
  };

  GamePlay.prototype.update = function() {
    var i, j, positionX, positionY, ref, results;
    if (debug) {
      console.log('GamePlay::update()');
    }
    this.bmd.update();
    results = [];
    for (i = j = 0, ref = this.nbJoueur - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
      positionX = this.joueurs[i].x - this.epaisseurMur / 2;
      positionY = this.joueurs[i].y - this.epaisseurMur / 2;
      this.bmd.context.fillStyle = this.couleursJ[i];
      this.bmd.ctx.fill();
      if (this.joueurs[i].alive) {
        this.collisionTest(this.joueurs[i]);
      }
      this.bmd.context.fillRect(positionX, positionY, this.epaisseurMur, this.epaisseurMur);
      results.push(this.bmd.dirty = true);
    }
    return results;
  };

  return GamePlay;

})();

//# sourceMappingURL=GamePlay.js.map
