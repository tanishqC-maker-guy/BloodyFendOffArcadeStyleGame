'''
Coded by Tanishq Chigullarevu
2026
'''
extends Node2D

'''
This is the script for the intro sequence for the game,
which is a small introductory scene of Otis the Sketch Spaniel.
'''

# Here we make this node do its animation here.
func _ready():
	await get_tree().create_timer(0.5).timeout
	#we do a little silly thing here where we generate a random number
	var rng = RandomNumberGenerator.new()
	'''
	we play the intro theme and also make it that if the random number
	is 1 out of 20 possible numbers, Otis is changed to a sign saying
	he's on lunch break.
	'''
	$WaggieGamesJingle.play()
	var otisThere = rng.randi_range(1, 20)
	if (otisThere == 1):
		otisThere = false
		$waggieLogoSprite.frame = 4

	'''
	We make a list of all the letters of Waggie Games (the label I use for my games),
	and make them all fall from the sky one by one to the music.
	'''
	var letterSprites = [$WaggieFontW, $WaggieFontA, $WaggieFontSmallG, $WaggieFontSmallG2, $WaggieFontI, $WaggieFontE, $WaggieFontBigG, $WaggieFontA2, $WaggieFontM, $WaggieFontE2, $WaggieFontS]
	for letter in letterSprites:
		var letterTween = create_tween().set_trans(Tween.TRANS_BOUNCE)
		letterTween.tween_property(letter, "position", letter.position + Vector2(0, 500), 0.27).set_ease(Tween.EASE_OUT)
		await get_tree().create_timer(0.127).timeout
	
	
	
	#here we use a tween to make Otis (or the sign) fall from the sky and play an animation.
	var landPosit = Vector2(260.0, 320.0)
	var flyPosit = Vector2(-250.0, 1200.0)
	var flyScale = Vector2(2.5, 2.8)
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_parallel()
	if (otisThere):
		tween.tween_property($waggieLogoSprite, "position", landPosit, 0.4).set_ease(Tween.EASE_IN)
		await get_tree().create_timer(0.4).timeout
		$waggieLogoSprite.frame = 1
		await get_tree().create_timer(0.1).timeout
		$waggieLogoSprite.frame = 2
		await get_tree().create_timer(0.9).timeout
		$WaggieLogoBrushBg.position = $WaggieLogoBrushBg.position + Vector2(0, 500)
		await get_tree().create_timer(1.5).timeout
	else:
		tween.tween_property($waggieLogoSprite, "position", landPosit + Vector2(0, 60.0), 0.6).set_ease(Tween.EASE_IN)
		await get_tree().create_timer(1.6).timeout
		$WaggieLogoBrushBg.position = $WaggieLogoBrushBg.position + Vector2(0, 500)
		await get_tree().create_timer(1.5).timeout
	
	#here we play a noise and launch the letters and Otis (or the sign) offscreen using tweens.
	$LightningStikeNoise.play()
	if (otisThere):
		$waggieLogoSprite.frame = 1
	var flyAwayTween = create_tween().set_trans(Tween.TRANS_CUBIC).set_parallel()
	flyAwayTween.tween_property($waggieLogoSprite, "position", flyPosit, 0.15).set_ease(Tween.EASE_IN)
	flyAwayTween.tween_property($waggieLogoSprite, "scale", flyScale, 0.15).set_ease(Tween.EASE_IN)
	flyAwayTween.tween_property($ColorRect, "color", Color.WHITE, 0.1)
	
	flyAwayTween.tween_property($WaggieLogoBrushBg, "position", $WaggieLogoBrushBg.position + Vector2(0, 690.0), 0.15).set_ease(Tween.EASE_IN)
	flyAwayTween.tween_property($WaggieLogoBrushBg, "scale", flyScale, 0.15).set_ease(Tween.EASE_IN)
	
	await get_tree().create_timer(0.025).timeout
	if (otisThere):
		$waggieLogoSprite.frame = 3
	
	var horizontalLetterValue = -30.0
	
	for letter in letterSprites:
		var flyLetterTween = create_tween().set_trans(Tween.TRANS_CUBIC)
		flyLetterTween.tween_property(letter, "position", letter.position + Vector2(horizontalLetterValue, 690.0), 0.15).set_ease(Tween.EASE_IN)
		flyLetterTween.tween_property(letter, "scale", flyScale, 0.15).set_ease(Tween.EASE_IN)
		horizontalLetterValue = horizontalLetterValue + 60.0
	
	var transitionTween = create_tween().set_trans(Tween.TRANS_CUBIC)
	
	transitionTween.tween_property($ColorRect, "color", Color("ffffff00"), 1)
	await get_tree().create_timer(1).timeout
	$ColorRect.visible = false

#if the player wants to skip the intro, they can press the fire button to skip.
func _process(_delta):
	if (Input.is_key_pressed(KEY_ENTER)):
		$LightningStikeNoise.volume_db = -80
		$WaggieGamesJingle.volume_db = -80
