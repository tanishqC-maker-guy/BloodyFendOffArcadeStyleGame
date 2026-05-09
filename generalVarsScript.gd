'''
Coded by Tanishq Chigullarevu
2026
'''
extends Node


'''
this is the general variables script, which holds all the 
variables that are needed throughout the game.
We got the bullet count, score, level, lives count, 
whether the main guy is dead, the game has started, 
can fire blood, the game is counting up blood remaining,
player is entering nickname, and a flag for if the player
got hit by one of the enemies.
'''
var bulletCount = 40
var scoreNumber = 0
var levelNumber = 0
var livesCount = 3
var isDead = false
var gameStarted = false
var canFire = true
var isCountingScore = false
var isEnteringNickname = false
var whoKilledMC = "no one"
'''
We also have variables for the glitch enemy.
It's rush direction, and how many times it's been triggered.
'''
var rushDirection = 0
var glitchTriggerCount = 0
'''
We also have variables for the dr hand man boss enemy.
It's rush direction, how many times it's been triggered,
its health, and how many times it's been hit in one combo.
'''
var drHandmanDirection = 0
var drHandmanTriggerCount = 0
var drHandmanHealth = 0
var DrHandmanHitCombo = 0
