'''
Coded by Tanishq Chigullarevu
2026
'''
extends AnimatedSprite2D

'''
here we have the script for the main character, which handles appearance and firing bullets.
'''

#these are the variables
var bullet = preload("res://bullet.tscn")
var bulletHoriSpeed = 0
var bulletVertiSpeed = 20
var bulletRotation = 0
var wasTrigged = false
var isDead = false
var gameStarted = false
var canFire = true

#this is the function that handles firing the blood bullets
func fire():
	#we create a bullet and make it fire in the direction we are facing
	var bullet_instance = bullet.instantiate()
	var bulletMove = Thread.new()
	canFire = false
	var instanceBulletHoriSpeed = bulletHoriSpeed
	var instancebulletVertiSpeed = bulletVertiSpeed
	if (GeneralVarsScript.bulletCount > 0):
		$ShootBullet8Bit.play()
		get_tree().get_root().call_deferred("add_child", bullet_instance)
		bullet_instance.position = Vector2(45, -10)
		var bulletVectorMoving = func ():
			for i in range(50):
				if (bullet_instance):
					bullet_instance.position = bullet_instance.position + Vector2(instanceBulletHoriSpeed, instancebulletVertiSpeed)
					await get_tree().create_timer(0.01).timeout
		bulletMove.start(bulletVectorMoving)
		await get_tree().create_timer(0.2).timeout
		canFire = true
		await get_tree().create_timer(4).timeout
		#then we wait for a cooldown to fire again
		bulletMove.wait_to_finish()
		#after the cooldown we delete the fired bullet
		if (bullet_instance):
			get_tree().queue_delete(bullet_instance)


func gameOverSequence():
	self.frame = 0
	self.position = Vector2(543, 373)
	isDead = true
	print(GeneralVarsScript.whoKilledMC)
	if (GeneralVarsScript.whoKilledMC != "no one"):
		GeneralVarsScript.whoKilledMC = "no one"
		await get_tree().create_timer(4).timeout
	
	await get_tree().create_timer(0.05).timeout
	GeneralVarsScript.isDead = true
	await get_tree().create_timer(1).timeout
	gameStarted = false

#this function runs on each frame during the game's process
func _process(_delta):
	#if the bullet count is at 0, we trigger the game over sequence.
	if (GeneralVarsScript.bulletCount <= 0 and isDead == false or GeneralVarsScript.whoKilledMC != "no one"):
		gameOverSequence()
	#if the game isn't started we have all these set to what they should be at the beginning
	if (not gameStarted):
		if (Input.is_key_pressed(KEY_ENTER)):
			self.visible = true
			gameStarted = true
			isDead = false
			self.position = Vector2(567, 349)
			self.frame = 2
			bulletHoriSpeed = 0
			bulletVertiSpeed = 20
			bulletRotation = 0
			canFire = true
			GeneralVarsScript.bulletCount = 40
	'''
	here depending on what key the player presses, 
	it changes what direction the player faces and 
	what direction the bullet will fire in
	'''
	if (not isDead and gameStarted):
		if (Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT)):
			self.frame = 1
			bulletHoriSpeed = 20
			bulletVertiSpeed = 0
			bulletRotation = -90
		if (Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT)):
			self.frame = 3
			bulletHoriSpeed = -20
			bulletVertiSpeed = 0
			bulletRotation = 180
		if (Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP)):
			self.frame = 4
			bulletHoriSpeed = 0
			bulletVertiSpeed = -20
			bulletRotation = 90
		if (Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN)):
			self.frame = 2
			bulletHoriSpeed = 0
			bulletVertiSpeed = 20
			bulletRotation = 0
		#here we make sure that if the player is allowed to fire and they press the key, then a bullet will shoot out
		if (Input.is_key_pressed(KEY_ENTER)):
			if (canFire and not GeneralVarsScript.isCountingScore and not GeneralVarsScript.isEnteringNickname):
				fire()
