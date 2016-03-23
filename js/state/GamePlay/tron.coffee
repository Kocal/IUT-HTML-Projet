
class tronBike
  posX: 0
  posY: 0
  direction: 0

  constructor: (posX, posY, direction) ->
    @posX = posX
    @posY = posY
    @direction = direction

  avance: () ->
    @posX-- if @direction == 3
    @posX++ if @direction == 1
    @posY-- if @direction == 0
    @posY++ if @direction == 2

  tourneDroite: () ->
    @direction++
    @direction = 0 if @direction == 4
    console.log 'tourne droite' if debug

  tourneGauche: () ->
    @direction--
    @direction = 3 if @direction == -1
    console.log 'tourne gauche' if debug

class tronEngine
  player1: 0
  player2: 0
  player3: 0
  player4: 0
  tronMap: []

  constructor: (dimensionX, dimensionY) ->
    @tronMap = new Array dimensionX*dimensionY
    @player1 = new tronBike 50,50,2
    @player2 = new tronBike 200,50,2
    @player3 = new tronBike 50,200,0
    @player4 = new tronBike 200,200,0

  nextStep: () ->
    do @player1.avance
    do @player2.avance
    do @player3.avance
    do @player4.avance

    console.log @player1.posX+" "+@player1.posY if debug
