// Generated by CoffeeScript 1.10.0
var GamePlay;

GamePlay = (function() {
  GamePlay.prototype.joueurs = [];

  GamePlay.prototype.bmd = null;

  GamePlay.prototype.globalVelocity = 100;

  GamePlay.prototype.epaisseurMur = 10;

  GamePlay.prototype.nbJoueur = 1;

  GamePlay.prototype.nbMort = 0;

  GamePlay.prototype.modeDeJeu = "pc";

  GamePlay.prototype.couleursJ = [];

  GamePlay.prototype.tickRefresh = 5;

  GamePlay.prototype.tick = 0;

  GamePlay.prototype.tourne = function(joueur, direction) {
    if (direction === "droite") {
      joueur.angle += 90;
    } else if (direction === "gauche") {
      joueur.angle -= 90;
    }
    return game.physics.arcade.velocityFromAngle(joueur.angle, this.globalVelocity, joueur.body.velocity);
  };

  GamePlay.prototype.collisionTest = function(joueur) {
    var i, j, len, posTempX, posTempY, ref, results, retour;
    if (joueur.x < 0 || joueur.x > game.width || joueur.y < 0 || joueur.y > game.height) {
      this.explode(joueur);
    }
    ref = [-this.epaisseurMur / 2, this.epaisseurMur / 2];
    results = [];
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];
      posTempX = joueur.x;
      posTempY = joueur.y;
      if (joueur.body.velocity.x > 1) {
        posTempX += joueur.width / 2 + 2;
        posTempY += i;
      } else if (joueur.body.velocity.x < -1) {
        posTempX -= joueur.width / 2 + 2;
        posTempY += i;
      } else if (joueur.body.velocity.y > 1) {
        posTempY += joueur.height / 2 + 2;
        posTempX += i;
      } else {
        posTempY -= joueur.height / 2 + 2;
        posTempX += i;
      }
      retour = this.bmd.getPixel(Math.round(posTempX), Math.round(posTempY));
      if (retour.a !== 0) {
        this.explode(joueur);
        break;
      } else {
        results.push(void 0);
      }
    }
    return results;
  };

  GamePlay.prototype.explode = function(joueur) {
    if (debug) {
      console.log("boum!");
    }
    this.nbMort++;
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
    game.load.image('fleche_gauche1', 'assets/img/fleche_gauche1.png');
    game.load.image('fleche_droite1', 'assets/img/fleche_droite1.png');
    game.load.image('fleche_gauche2', 'assets/img/fleche_gauche2.png');
    game.load.image('fleche_droite2', 'assets/img/fleche_droite2.png');
    game.load.image('fleche_gauche3', 'assets/img/fleche_gauche3.png');
    game.load.image('fleche_droite3', 'assets/img/fleche_droite3.png');
    game.load.image('fleche_gauche4', 'assets/img/fleche_gauche4.png');
    game.load.image('fleche_droite4', 'assets/img/fleche_droite4.png');
    game.load.image('touche_a', 'assets/img/A.png');
    game.load.image('touche_z', 'assets/img/Z.png');
    game.load.image('touche_t', 'assets/img/T.png');
    game.load.image('touche_y', 'assets/img/Y.png');
    game.load.image('touche_o', 'assets/img/O.png');
    game.load.image('touche_p', 'assets/img/P.png');
    game.load.image('touche_g', 'assets/img/G.png');
    return game.load.image('touche_d', 'assets/img/D.png');
  };

  GamePlay.prototype.create = function() {
    var bg, btD, btEchap, btG, i, j, k, ref, ref1, sprite, spriteD, spriteG;
    if (debug) {
      console.log('GamePlay::create()');
    }
    this.epaisseurMur = Math.round(game.width / 100);
    game.physics.startSystem(Phaser.Physics.ARCADE);
    game.stage.backgroundColor = '#124184';
    this.nbMort = 0;
    this.couleursJ = new Array(4);
    this.couleursJ[0] = '#00ff00';
    this.couleursJ[1] = '#00ffff';
    this.couleursJ[2] = '#ff00ff';
    this.couleursJ[3] = '#ffff00';
    if (this.joueurs) {
      this.joueurs = [];
    }
    for (i = j = 0, ref = this.nbJoueur - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
      this.joueurs.push(game.add.sprite(0, 0, null));
      this.joueurs[i].width = this.epaisseurMur;
      this.joueurs[i].height = this.epaisseurMur;
      game.physics.arcade.enable(this.joueurs[i], Phaser.Physics.ARCADE);
      this.joueurs[i].body.velocity.x = this.globalVelocity;
      this.joueurs[i].anchor.set(0.5);
    }
    if (this.nbJoueur === 1) {
      this.joueurs[0].x = game.width / 2;
      this.joueurs[0].y = game.height / 2;
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
    btEchap = this.input.keyboard.addKey(Phaser.Keyboard.ESC);
    btEchap.onDown.add(this.leaveGave, this);
    this.tickRefresh = 5;
    if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
      this.modeDeJeu = "mobile";
    }
    if (this.modeDeJeu === "mobile") {
      this.tickRefresh *= 2;
      spriteG = game.add.sprite(0, 0, 'fleche_gauche1');
      spriteG.scale.setTo(0.2, 0.2);
      spriteD = game.add.sprite(50, 0, 'fleche_droite1');
      spriteD.scale.setTo(0.2, 0.2);
      spriteG.inputEnabled = true;
      spriteG.events.onInputDown.add(this.listenerBoutonG1, this);
      spriteD.inputEnabled = true;
      spriteD.events.onInputDown.add(this.listenerBoutonD1, this);
      if (this.nbJoueur >= 2) {
        spriteG = game.add.sprite(0, 0, 'fleche_gauche2');
        spriteG.scale.setTo(0.2, 0.2);
        spriteG.x = game.width - (spriteG.width * 2);
        spriteD = game.add.sprite(50, 0, 'fleche_droite2');
        spriteD.scale.setTo(0.2, 0.2);
        spriteD.x = game.width - spriteG.width;
        spriteG.inputEnabled = true;
        spriteG.events.onInputDown.add(this.listenerBoutonG2, this);
        spriteD.inputEnabled = true;
        spriteD.events.onInputDown.add(this.listenerBoutonD2, this);
        if (this.nbJoueur >= 3) {
          spriteG = game.add.sprite(0, 0, 'fleche_gauche3');
          spriteG.scale.setTo(0.2, 0.2);
          spriteG.y = game.height - spriteG.height;
          spriteD = game.add.sprite(50, 0, 'fleche_droite3');
          spriteD.scale.setTo(0.2, 0.2);
          spriteD.y = game.height - spriteG.height;
          spriteG.inputEnabled = true;
          spriteG.events.onInputDown.add(this.listenerBoutonG3, this);
          spriteD.inputEnabled = true;
          spriteD.events.onInputDown.add(this.listenerBoutonD3, this);
          if (this.nbJoueur === 4) {
            spriteG = game.add.sprite(0, 0, 'fleche_gauche4');
            spriteG.scale.setTo(0.2, 0.2);
            spriteG.x = game.width - (spriteG.width * 2);
            spriteG.y = game.height - spriteG.height;
            spriteD = game.add.sprite(50, 0, 'fleche_droite4');
            spriteD.scale.setTo(0.2, 0.2);
            spriteD.x = game.width - spriteG.width;
            spriteD.y = game.height - spriteG.height;
            spriteG.inputEnabled = true;
            spriteG.events.onInputDown.add(this.listenerBoutonG4, this);
            spriteD.inputEnabled = true;
            return spriteD.events.onInputDown.add(this.listenerBoutonD4, this);
          }
        }
      }
    } else {
      btG = this.input.keyboard.addKey(Phaser.Keyboard.A);
      btG.onDown.add(this.listenerBoutonG1, this);
      btD = this.input.keyboard.addKey(Phaser.Keyboard.Z);
      btD.onDown.add(this.listenerBoutonD1, this);
      sprite = game.add.sprite(0, 0, 'touche_a');
      sprite = game.add.sprite(sprite.width, 0, 'touche_z');
      if (this.nbJoueur >= 2) {
        btG = this.input.keyboard.addKey(Phaser.Keyboard.T);
        btG.onDown.add(this.listenerBoutonG2, this);
        btD = this.input.keyboard.addKey(Phaser.Keyboard.Y);
        btD.onDown.add(this.listenerBoutonD2, this);
        sprite = game.add.sprite(game.width - sprite.width * 2, 0, 'touche_t');
        sprite = game.add.sprite(game.width - sprite.width, 0, 'touche_y');
        if (this.nbJoueur >= 3) {
          btG = this.input.keyboard.addKey(Phaser.Keyboard.O);
          btG.onDown.add(this.listenerBoutonG3, this);
          btD = this.input.keyboard.addKey(Phaser.Keyboard.P);
          btD.onDown.add(this.listenerBoutonD3, this);
          sprite = game.add.sprite(0, game.height - sprite.height, 'touche_o');
          sprite = game.add.sprite(sprite.width, game.height - sprite.height, 'touche_p');
          if (this.nbJoueur === 4) {
            btG = this.input.keyboard.addKey(Phaser.Keyboard.LEFT);
            btG.onDown.add(this.listenerBoutonG4, this);
            btD = this.input.keyboard.addKey(Phaser.Keyboard.RIGHT);
            btD.onDown.add(this.listenerBoutonD4, this);
            sprite = game.add.sprite(game.width - sprite.width, game.height - sprite.height, 'touche_g');
            return sprite = game.add.sprite(game.width - sprite.width * 2, sprite.y, 'touche_d');
          }
        }
      }
    }
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

  GamePlay.prototype.listenerBoutonG2 = function() {
    if (debug) {
      console.log("bonton gauche");
    }
    return this.tourne(this.joueurs[1], "gauche");
  };

  GamePlay.prototype.listenerBoutonD2 = function() {
    if (debug) {
      console.log("bonton droit");
    }
    return this.tourne(this.joueurs[1], "droite");
  };

  GamePlay.prototype.listenerBoutonG3 = function() {
    if (debug) {
      console.log("bonton gauche");
    }
    return this.tourne(this.joueurs[2], "gauche");
  };

  GamePlay.prototype.listenerBoutonD3 = function() {
    if (debug) {
      console.log("bonton droit");
    }
    return this.tourne(this.joueurs[2], "droite");
  };

  GamePlay.prototype.listenerBoutonG4 = function() {
    if (debug) {
      console.log("bonton gauche");
    }
    return this.tourne(this.joueurs[3], "gauche");
  };

  GamePlay.prototype.listenerBoutonD4 = function() {
    if (debug) {
      console.log("bonton droit");
    }
    return this.tourne(this.joueurs[3], "droite");
  };

  GamePlay.prototype.winnerScreen = function() {
    return game.state.start(game.state.current, true, true, this.nbJoueur);
  };

  GamePlay.prototype.leaveGave = function() {
    return game.state.start('GameTitle', true, true);
  };

  GamePlay.prototype.update = function() {
    var i, j, positionX, positionY, ref, results;
    if (debug) {
      console.log('GamePlay::update()');
    }
    this.tick++;
    if (this.tick >= this.tickRefresh) {
      this.tick = 0;
      this.bmd.update();
    }
    if (this.nbMort < this.nbJoueur) {
      results = [];
      for (i = j = 0, ref = this.nbJoueur - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
        if (this.joueurs[i].alive) {
          positionX = this.joueurs[i].x - this.epaisseurMur / 2;
          positionY = this.joueurs[i].y - this.epaisseurMur / 2;
          this.bmd.context.fillStyle = this.couleursJ[i];
          this.bmd.ctx.fill();
          this.collisionTest(this.joueurs[i]);
          this.bmd.context.fillRect(positionX, positionY, this.epaisseurMur, this.epaisseurMur);
          results.push(this.bmd.dirty = true);
        } else {
          results.push(void 0);
        }
      }
      return results;
    } else {
      return this.winnerScreen();
    }
  };

  return GamePlay;

})();

//# sourceMappingURL=GamePlay.js.map
