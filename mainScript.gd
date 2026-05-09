'''
Coded by Tanishq Chigullarevu
2026
'''
extends Node2D

'''
this is the main script, which controls stuff like spawning enemies,
their behaviors, score and bullet count. 
'''

#this holds what score will activate the final boss
var finalBossScoreRequirement = 20000

#the behavior for the two simple walking enemies, the manster and bear
func simpleWalkEnemySpawn():
	#here we set a random number generator to choose which direction the enemy will go
	var rng = RandomNumberGenerator.new()
	var spawnType = rng.randi_range(1, 4)
	#next we also set the variables of the walker object themselves, being null as we need to see which direction they're going first
	var simpleWalkerEnemy = null
	var sentsimpleWalkerEnemy = null
	#finally we have the velocity of their movement horizontally and vertically, used later
	var simpleWalkerHoriVelocity = -20
	var simpleWalkerVertiVelocity = 0
	
	#here we have a bear or manster enemy spawned in with the velocities and spawn position now assigned depending on the random number
	if (spawnType == 1):
		simpleWalkerEnemy = preload("res://bear_enemy_newest.tscn")
		sentsimpleWalkerEnemy = simpleWalkerEnemy.instantiate()
		add_child(sentsimpleWalkerEnemy)
		sentsimpleWalkerEnemy.reparent($EnemyLayer)
		simpleWalkerHoriVelocity = -15
		simpleWalkerVertiVelocity = 0
		sentsimpleWalkerEnemy.position = $RightSpawnPoint.position
	elif (spawnType == 2):
		simpleWalkerEnemy = preload("res://manster_enemy.tscn")
		sentsimpleWalkerEnemy = simpleWalkerEnemy.instantiate()
		add_child(sentsimpleWalkerEnemy)
		sentsimpleWalkerEnemy.reparent($EnemyLayer)
		simpleWalkerHoriVelocity = 15
		simpleWalkerVertiVelocity = 0
		sentsimpleWalkerEnemy.position = $LeftSpawnPoint.position
	elif (spawnType == 3):
		simpleWalkerEnemy = preload("res://manster_enemy.tscn")
		sentsimpleWalkerEnemy = simpleWalkerEnemy.instantiate()
		add_child(sentsimpleWalkerEnemy)
		sentsimpleWalkerEnemy.reparent($EnemyLayer)
		simpleWalkerHoriVelocity = 0
		simpleWalkerVertiVelocity = 10
		sentsimpleWalkerEnemy.position = $TopSpawnPoint.position
	elif (spawnType == 4):
		simpleWalkerEnemy = preload("res://bear_enemy_newest.tscn")
		sentsimpleWalkerEnemy = simpleWalkerEnemy.instantiate()
		add_child(sentsimpleWalkerEnemy)
		sentsimpleWalkerEnemy.reparent($EnemyLayer)
		simpleWalkerHoriVelocity = 0
		simpleWalkerVertiVelocity = -10
		sentsimpleWalkerEnemy.position = $BottomSpawnPoint.position
	
	#here we edit the vertical and horizontal velocity of this enemy to be a speed corrosponding to how difficult the game is right now
	var finalSimpleWalkerHoriVelocity = simpleWalkerHoriVelocity + GeneralVarsScript.levelNumber*simpleWalkerHoriVelocity/12.0
	var finalSimpleWalkerVertiVelocity = simpleWalkerVertiVelocity + GeneralVarsScript.levelNumber*simpleWalkerVertiVelocity/16.0
	#now we have the enemy actually move towards the player depending on the velocities it was assigned
	for i in range(60):
		if (sentsimpleWalkerEnemy):
			sentsimpleWalkerEnemy.position = sentsimpleWalkerEnemy.position + Vector2(finalSimpleWalkerHoriVelocity, finalSimpleWalkerVertiVelocity)
			await get_tree().create_timer(0.075).timeout

#the behavior for the bat
func batSpawn():
	#here we set a random number generator to choose which direction the bat will go
	var rng = RandomNumberGenerator.new()
	var spawnType = rng.randi_range(1, 4)
	#next we also set the variables of the bat object themselves
	var batEnemy = preload("res://bat_enemy.tscn")
	var sentBatEnemy = batEnemy.instantiate()
	add_child(sentBatEnemy)
	sentBatEnemy.reparent($EnemyLayer)
	#finally we have the velocity of their movement horizontally and vertically, used later
	var batHoriVelocity = -20
	var batVertiVelocity = 0
	#we also have the jump velocities used later
	var batHoriJumpVelocity = 0.0
	var batVertiJumpVelocity = 0.0
	
	#here we have the velocities and spawn position now assigned depending on the random number
	if (spawnType == 1):
		batVertiVelocity = 40
		batHoriVelocity = 0
		batHoriJumpVelocity = -50.0
		batVertiJumpVelocity = 0.0
		sentBatEnemy.position = $RightSpawnPoint.position
	elif (spawnType == 2):
		batVertiVelocity = 40
		batHoriVelocity = 0
		batHoriJumpVelocity = 50.0
		batVertiJumpVelocity = 0.0
		sentBatEnemy.position = $LeftSpawnPoint.position
	elif (spawnType == 3):
		batVertiVelocity = 0
		batHoriVelocity = 40
		batHoriJumpVelocity = 0.0
		batVertiJumpVelocity = 60.0
		sentBatEnemy.position = $TopSpawnPoint.position
	elif (spawnType == 4):
		batVertiVelocity = 0
		batHoriVelocity = 40
		batHoriJumpVelocity = 0.0
		batVertiJumpVelocity = -60.0
		sentBatEnemy.position = $BottomSpawnPoint.position
	sentBatEnemy.position = sentBatEnemy.position + Vector2(batHoriJumpVelocity, batVertiJumpVelocity)
	
	#now we have the bat actually move towards the player depending on the velocities it was assigned, plus the jump velocities used to get the swaying motions in its path
	for i in range(8):
		if (sentBatEnemy):
			for o in range(3):
				if (sentBatEnemy):
					sentBatEnemy.position = sentBatEnemy.position + Vector2(batHoriVelocity/1.5, batVertiVelocity/1.5)
					sentBatEnemy.position = sentBatEnemy.position + Vector2(batHoriJumpVelocity/6.0, batVertiJumpVelocity/6.0)
					await get_tree().create_timer(0.05).timeout
			for p in range(6):
				if (sentBatEnemy):
					sentBatEnemy.position = sentBatEnemy.position + Vector2(-batHoriVelocity/1.5, -batVertiVelocity/1.5)
					sentBatEnemy.position = sentBatEnemy.position + Vector2(batHoriJumpVelocity/6.0, batVertiJumpVelocity/6.0)
					await get_tree().create_timer(0.05).timeout
			for q in range(3):
				if (sentBatEnemy):
					sentBatEnemy.position = sentBatEnemy.position + Vector2(batHoriVelocity/1.5, batVertiVelocity/1.5)
					#foward movement
					sentBatEnemy.position = sentBatEnemy.position + Vector2(batHoriJumpVelocity/6.0, batVertiJumpVelocity/6.0)
					await get_tree().create_timer(0.05).timeout
	
	#if the bat makes it to the player it deletes itself
	if (sentBatEnemy):
		sentBatEnemy.queue_free()

#the behavior for the health refill pumpkin
func pumpkinSpawn():
	#here we set a random number generator to choose which direction the pumpkin will go
	var rng = RandomNumberGenerator.new()
	var spawnType = rng.randi_range(1, 4)
	#next we also set the variables of the bat pumpkin themselves
	var bloodPumpkin = preload("res://blood_pumpkin.tscn")
	var sentBloodPumpkin = bloodPumpkin.instantiate()
	add_child(sentBloodPumpkin)
	sentBloodPumpkin.reparent($EnemyLayer)
	#finally we have the velocity of their movement horizontally and vertically, used later
	var pumpkinHoriVelocity = 0
	var pumpkinVertiVelocity = 0
	#we also have the jump velocities used later
	var pumpkinHoriJumpVelocity = 0
	var pumpkinVertiJumpVelocity = 0
	
	#here we have the velocities and spawn position now assigned depending on the random number. We also set the jump velocities too used to shift the pumpkin into screen view
	if (spawnType == 1):
		pumpkinVertiVelocity = 40
		pumpkinHoriVelocity = 0
		pumpkinHoriJumpVelocity = -200
		pumpkinVertiJumpVelocity = 0
		sentBloodPumpkin.position = $RightSpawnPoint.position
	elif (spawnType == 2):
		pumpkinVertiVelocity = 40
		pumpkinHoriVelocity = 0
		pumpkinHoriJumpVelocity = 200
		pumpkinVertiJumpVelocity = 0
		sentBloodPumpkin.position = $LeftSpawnPoint.position
	elif (spawnType == 3):
		pumpkinVertiVelocity = 0
		pumpkinHoriVelocity = 40
		pumpkinHoriJumpVelocity = 0
		pumpkinVertiJumpVelocity = 100
		sentBloodPumpkin.position = $TopSpawnPoint.position
	elif (spawnType == 4):
		pumpkinVertiVelocity = 0
		pumpkinHoriVelocity = 40
		pumpkinHoriJumpVelocity = 0
		pumpkinVertiJumpVelocity = -100
		sentBloodPumpkin.position = $BottomSpawnPoint.position
	sentBloodPumpkin.position = sentBloodPumpkin.position + Vector2(pumpkinHoriJumpVelocity, pumpkinVertiJumpVelocity)
	
	#now we have the pumpkin actually move towards the player depending on the velocities it was assigned, the velocities used to get the swaying motions in its path
	for i in range(4):
		if (sentBloodPumpkin):
			for o in range(3):
				if (sentBloodPumpkin):
					sentBloodPumpkin.position = sentBloodPumpkin.position + Vector2(pumpkinHoriVelocity, pumpkinVertiVelocity)
					await get_tree().create_timer(0.05).timeout
			for p in range(6):
				if (sentBloodPumpkin):
					sentBloodPumpkin.position = sentBloodPumpkin.position + Vector2(-pumpkinHoriVelocity, -pumpkinVertiVelocity)
					await get_tree().create_timer(0.05).timeout
			for q in range(3):
				if (sentBloodPumpkin):
					sentBloodPumpkin.position = sentBloodPumpkin.position + Vector2(pumpkinHoriVelocity, pumpkinVertiVelocity)
					await get_tree().create_timer(0.05).timeout
	
	#if the pumpkin hasn't been fired by player by now it deletes itself
	if (sentBloodPumpkin):
		sentBloodPumpkin.queue_free()

#the behavior for the glitch enemy
func glitchManSpawn():
	#we have the velocity of their movement horizontally and vertically, used later
	var glitchRunnerHoriVelocity = -20
	var glitchRunnerVertiVelocity = 0
	
	if (GeneralVarsScript.glitchTriggerCount == 0 and not GeneralVarsScript.isDead):
		GeneralVarsScript.glitchTriggerCount = GeneralVarsScript.glitchTriggerCount + 1
		'''
		Here is the segment where we spawn in the glitch enemy 
		and its direction arrow and have them slides into 
		frame to show the player which way the enemy will rush
		towards them at.
		'''
		#here we spawn the enemy and arrow
		var arrowGraphic = preload("res://direction_arrow.tscn")
		var sentArrow = arrowGraphic.instantiate()
		var glitchRunnerEnemy = preload("res://glitch_enemy.tscn")
		var sentGlitchRunnerEnemy = glitchRunnerEnemy.instantiate()
		add_child(sentGlitchRunnerEnemy)
		sentGlitchRunnerEnemy.position = $BottomSpawnPoint.position + Vector2(-180, 0)
		sentArrow.position = $BottomSpawnPoint.position + Vector2(-170, -240)
		sentArrow.reparent($EnemyLayer)
		
		#then we slide them in
		for i in range(4):
			if (sentGlitchRunnerEnemy):
				sentGlitchRunnerEnemy.position = sentGlitchRunnerEnemy.position + Vector2(0, -42)
				await get_tree().create_timer(0.075).timeout
		await get_tree().create_timer(0.3).timeout
		#add the arrow which then shows the direction
		add_child(sentArrow)
		await get_tree().create_timer(4.5).timeout
		#then we clear the arrow and glitch enemy
		for i in range(4):
			if (sentGlitchRunnerEnemy):
				sentGlitchRunnerEnemy.position = sentGlitchRunnerEnemy.position + Vector2(0, 42)
				await get_tree().create_timer(0.075).timeout
		if (sentGlitchRunnerEnemy):
			sentGlitchRunnerEnemy.queue_free()
	elif (GeneralVarsScript.glitchTriggerCount < 7 and GeneralVarsScript.glitchTriggerCount > 0):
		'''
		In order for the glitch enemy to not spawn in all the time,
		if it tries spawning, we have it add to a counter and spawn
		a simple enemy instead.
		'''
		GeneralVarsScript.glitchTriggerCount = GeneralVarsScript.glitchTriggerCount + 1
		simpleWalkEnemySpawn()
		print("glitch man trigger value: " + str(GeneralVarsScript.glitchTriggerCount))
	else:
		'''
		This is where after the glitch enemy gets enough points to
		finally attack, it uses the spawnType value to see where to
		rush at
		'''
		#we spawn in the glitch enemy object
		var glitchRunnerEnemy = preload("res://glitch_enemy.tscn")
		var sentGlitchRunnerEnemy = glitchRunnerEnemy.instantiate()
		add_child(sentGlitchRunnerEnemy)
		sentGlitchRunnerEnemy.reparent($EnemyLayer)
		
		#we set the glitchTriggerCount to 0 and set the position and velocities
		GeneralVarsScript.glitchTriggerCount = 0
		if (GeneralVarsScript.rushDirection == 1):
			glitchRunnerHoriVelocity = -60
			glitchRunnerVertiVelocity = 0
			sentGlitchRunnerEnemy.position = $RightSpawnPoint.position
		elif (GeneralVarsScript.rushDirection == 2):
			glitchRunnerHoriVelocity = 60
			glitchRunnerVertiVelocity = 0
			sentGlitchRunnerEnemy.position = $LeftSpawnPoint.position
		elif (GeneralVarsScript.rushDirection == 3):
			glitchRunnerHoriVelocity = 0
			glitchRunnerVertiVelocity = 30
			sentGlitchRunnerEnemy.position = $TopSpawnPoint.position + Vector2(0, 60)
		elif (GeneralVarsScript.rushDirection == 4):
			glitchRunnerHoriVelocity = 0
			glitchRunnerVertiVelocity = -30
			sentGlitchRunnerEnemy.position = $BottomSpawnPoint.position
		
		#we reset the rush direction and make the enmy actually dash towards the player
		GeneralVarsScript.rushDirection = 0
		for i in range(11):
			if (sentGlitchRunnerEnemy):
				sentGlitchRunnerEnemy.position = sentGlitchRunnerEnemy.position + Vector2(glitchRunnerHoriVelocity, glitchRunnerVertiVelocity)
				await get_tree().create_timer(0.075).timeout

#the behavior for the dr Handman boss
func drHandmanSpawn():
	#we have the velocity of their movement horizontally and vertically, used later
	var drHandmanHoriVelocity = -10
	var drHandmanVertiVelocity = 0
	
	#if the boss has had all its health depleted then we do the boss ending
	if (GeneralVarsScript.drHandmanHealth <= 0 and not GeneralVarsScript.isDead):
		#we disable the player's firing ability and stop the boss music
		GeneralVarsScript.canFire = false
		$handmanBgMusic.stop()
		
		#we spawn the boss at the bottom of the screen
		var drHandmanEnemy = preload("res://handman_main_head.tscn")
		var sentDrHandmanEnemy = drHandmanEnemy.instantiate()
		add_child(sentDrHandmanEnemy)
		sentDrHandmanEnemy.reparent($EnemyLayer)
		sentDrHandmanEnemy.position = $BottomSpawnPoint.position + Vector2(0, -150)
		
		#and then have explosions happen to it to show it dying, and then delete it
		for i in range(30):
			var randomXVal = RandomNumberGenerator.new().randi_range(-4, 4)
			var randomYVal = RandomNumberGenerator.new().randi_range(-4, 4)
			
			var deathExplosion = preload("res://death_splat_effect.tscn")
			var sentDeathExplosion = deathExplosion.instantiate()
			add_child(sentDeathExplosion)
			sentDeathExplosion.reparent($EnemyLayer)
			sentDeathExplosion.position = $BottomSpawnPoint.position + Vector2(randomXVal * 10, randomYVal * 10 + -150)
			$Damaged8Bit.play()
			await get_tree().create_timer(0.1).timeout
		sentDrHandmanEnemy.queue_free()
		
		#We then do a blood tally to add score depending on how much blood was left over.
		GeneralVarsScript.isCountingScore = true
		#we pitch up the damage sfx to make the blood tally sfx
		await get_tree().create_timer(3).timeout
		$Damaged8Bit.pitch_scale = 4.0
		#now we count each bullet to the score
		for i in range(GeneralVarsScript.bulletCount):
			$Control/BloodMeter.scale = $Control/BloodMeter.scale - Vector2(0.025, 0)
			$Damaged8Bit.play()
			GeneralVarsScript.scoreNumber = GeneralVarsScript.scoreNumber + 50
			await get_tree().create_timer(0.1).timeout
		await get_tree().create_timer(2).timeout
		
		#next we turn all the trees into angels and play the ending music
		$PixelTreeSprite.frame = 0
		$PixelTreeSprite2.frame = 0
		$PixelTreeSprite3.frame = 0
		$PixelTreeSprite5.frame = 0
		$PixelTreeSprite6.frame = 0
		$PixelTreeSprite7.frame = 0
		$FinalJingle8Bit.play()
		await get_tree().create_timer(9.6).timeout
		$BigMedal.visible = true
		
		#we up the final boss requirement and make it so the player can continue after the ending
		finalBossScoreRequirement = finalBossScoreRequirement + 20000
		await get_tree().create_timer(5).timeout
		GeneralVarsScript.gameStarted = false
		GeneralVarsScript.isEnteringNickname = false
		$InsertCoinLabel.visible = true
		$InsertCoinLabel.text = "CONTINUE"
	elif (GeneralVarsScript.drHandmanTriggerCount == 0 and not GeneralVarsScript.isDead):
		
		#this is the value used to see if the head should retreat
		var gotBeatenUp = false
		
		#now we have the normal music stop and play the boss music instead
		$Bgmusic8Bit.stop()
		await get_tree().create_timer(0.8).timeout
		$handmanBgMusic.play()
		'''
		Here is the segment where the final boss shows up and
		plays its reveal animation at the bottom spawn point.
		This is an introductory segment to let the player understand
		how the boss works.
		'''
		var drHandmanEnemy = preload("res://handman_main_head.tscn")
		var sentDrHandmanEnemy = drHandmanEnemy.instantiate()
		add_child(sentDrHandmanEnemy)
		sentDrHandmanEnemy.reparent($EnemyLayer)
		sentDrHandmanEnemy.position = $BottomSpawnPoint.position + Vector2(0, -150)
		'''
		we wait two seconds to then have a for loop to move the 
		boss head towards the player
		'''
		await get_tree().create_timer(2.8).timeout
		for i in range(8):
			#if the player has depleted its health 4 times, it sets its retreat value to yes and breaks the moving loop
			if (GeneralVarsScript.DrHandmanHitCombo >= 4):
				gotBeatenUp = true
				break
			sentDrHandmanEnemy.position = sentDrHandmanEnemy.position + Vector2(0, -20)
			await get_tree().create_timer(1).timeout
		#if the head got depleted 4 times, we make it retreat with this for loop and add 1 to its trigger value
		if (gotBeatenUp == true):
			for i in range(8):
				sentDrHandmanEnemy.position = sentDrHandmanEnemy.position + Vector2(0, 40)
				await get_tree().create_timer(0.1).timeout
			if (sentDrHandmanEnemy):
				sentDrHandmanEnemy.queue_free()
		GeneralVarsScript.drHandmanTriggerCount = 1
		GeneralVarsScript.DrHandmanHitCombo = 0
		#we then call the boss loop to start the loop
		bossFightEnemySpawnLoop()
	elif (GeneralVarsScript.drHandmanTriggerCount == 1 and not GeneralVarsScript.isDead):
		'''
		This is the segment that makes up the rest of the boss' behavior
		for the rest of the fight until it dies.
		'''
		
		#here we first set its direction with a random number between 1 to 4
		var rng = RandomNumberGenerator.new()
		var spawnType = rng.randi_range(1, 4)
		
		#this is the value used to see if the head should retreat
		var gotBeatenUp = false
		
		#next we also set the variables of the boss object themselves
		var drHandmanEnemy = preload("res://handman_main_head.tscn")
		var sentDrHandmanEnemy = drHandmanEnemy.instantiate()
		add_child(sentDrHandmanEnemy)
		sentDrHandmanEnemy.reparent($EnemyLayer)
		
		#here we have the velocities and spawn position now assigned depending on the random number
		if (spawnType == 1):
			drHandmanHoriVelocity = -30
			drHandmanVertiVelocity = 0
			sentDrHandmanEnemy.position = $RightSpawnPoint.position
		elif (spawnType == 2):
			drHandmanHoriVelocity = 30
			drHandmanVertiVelocity = 0
			sentDrHandmanEnemy.position = $LeftSpawnPoint.position
		elif (spawnType == 3):
			drHandmanHoriVelocity = 0
			drHandmanVertiVelocity = 15
			sentDrHandmanEnemy.position = $TopSpawnPoint.position
		elif (spawnType == 4):
			drHandmanHoriVelocity = 0
			drHandmanVertiVelocity = -15
			sentDrHandmanEnemy.position = $BottomSpawnPoint.position
		
		#we now have the boss move towards the player
		for i in range(22):
			if (sentDrHandmanEnemy):
				#if the player has depleted its health 4 times, it sets its retreat value to yes and breaks the moving loop
				if (GeneralVarsScript.DrHandmanHitCombo >= 4):
					gotBeatenUp = true
					break
				sentDrHandmanEnemy.position = sentDrHandmanEnemy.position + Vector2(drHandmanHoriVelocity, drHandmanVertiVelocity)
				await get_tree().create_timer(0.5).timeout
		
		#if the head got depleted 4 times, we make it retreat with this for loop and add 1 to its trigger value
		if (gotBeatenUp == true):
			for j in range(8):
				if (sentDrHandmanEnemy):
					sentDrHandmanEnemy.position = sentDrHandmanEnemy.position + Vector2(-drHandmanHoriVelocity*3, -drHandmanVertiVelocity*3)
					await get_tree().create_timer(0.1).timeout
			if (sentDrHandmanEnemy):
				sentDrHandmanEnemy.queue_free()
		GeneralVarsScript.DrHandmanHitCombo = 0
		
		#if the player sent off the boss we spawn the head again and a pumpkin to help the player
		pumpkinSpawn()
		drHandmanSpawn()

#the code for handling firing bullets with how it affects the other things here
func fire():
	#here when the player wants to fire, we minus 1 the bullet count and make firing temporarily unavaliable
	GeneralVarsScript.bulletCount = GeneralVarsScript.bulletCount - 1
	GeneralVarsScript.canFire = false
	
	#if the player still has bullets, just play a sound and then restore firing ability
	if (GeneralVarsScript.bulletCount > 0):
		$ShootBullet8Bit.play()
		await get_tree().create_timer(0.2).timeout
		GeneralVarsScript.canFire = true

#the code for the normal enemy spawning loop
func enemySpawnLoop():
	'''
	this is the enemy spawn loop which breaks when the player's 
	dead, otherwise it spawns something and then waits a 
	small second to spawn another enemy. After it spawns all its
	enemies, it tallies blood score and finishes the round.
	'''
	
	#if the player gets a score that's the finalBossScoreRequirement value or more, we trigger the boss fight
	if (GeneralVarsScript.scoreNumber >= finalBossScoreRequirement):
		drHandmanSpawn()
	#otherwise we just do the normal enemy spawning
	else:
		#this is the enemy loop itself which counts very quick
		for i in range(450):
			'''
			if on this quick second the player's dead, the game
			clears all the enemies and blood refills so they don't
			trigger another game over and break the for loop of
			spawning.
			'''
			if GeneralVarsScript.isDead or GeneralVarsScript.whoKilledMC != "no one":
				if (GeneralVarsScript.whoKilledMC == "manster"):
					GeneralVarsScript.whoKilledMC = "no one"
					print("manster rip out")
				for currentEnemy in $EnemyLayer.get_children():
					currentEnemy.queue_free()
				break
			'''
			Here on each quick second that's equal to one second,
			we use rng to spawn either a refill, or an enemy.
			'''
			if (i % 10 == 0):
				print(i)
				var rng = RandomNumberGenerator.new()
				var spawnType = rng.randi_range(1, 6)
				if (spawnType == 1):
					'''
					this spawns a health refill,
					that being a bloody pumpkin.
					'''
					pumpkinSpawn()
				else:
					'''
					if we're spawning an enemy, we randomly choose
					if it's a simpleWalker, a man monster guy, or a strange ASTHETICALLY
					glitched enemy.
					'''
					var enemyRng = RandomNumberGenerator.new()
					var enemyType = enemyRng.randi_range(1, GeneralVarsScript.levelNumber)
					print(enemyType)
					if (enemyType <= 3):
						simpleWalkEnemySpawn()
					elif (enemyType >= 4 and enemyType <= 7):
						batSpawn()
					elif (enemyType >= 8):
						glitchManSpawn()
						
			#We now wait a quick second.
			await get_tree().create_timer(0.075).timeout
			'''
			This is the blood tally, which tallies all the blood 
			bullets the player has left to their score, and then
			gives them a full blood count again.
			'''
		if (GeneralVarsScript.isDead == false):
			#if the player's still alive, we disable their firing ability and turn on counting
			GeneralVarsScript.canFire = false
			GeneralVarsScript.isCountingScore = true
			$Bgmusic8Bit.stop()
			for currentEnemy in $EnemyLayer.get_children():
				currentEnemy.queue_free()
			#we wait 3 seconds and then pitch up the damage sfx to make the blood tally sfx
			await get_tree().create_timer(2).timeout
			$Damaged8Bit.pitch_scale = 4.0
			#now we count each bullet to the score
			for i in range(GeneralVarsScript.bulletCount):
				$Control/BloodMeter.scale = $Control/BloodMeter.scale - Vector2(0.025, 0)
				$Damaged8Bit.play()
				GeneralVarsScript.scoreNumber = GeneralVarsScript.scoreNumber + 50
				await get_tree().create_timer(0.1).timeout
			await get_tree().create_timer(0.1).timeout
			#finally we play a victory jingle and give the player firing ability for a full tank
			$Damaged8Bit.pitch_scale = 1.0
			$Finished8Bit.play()
			await get_tree().create_timer(7).timeout
			$HealthRefill8Bit.play()
			GeneralVarsScript.bulletCount = 40
			$Bgmusic8Bit.play()
			GeneralVarsScript.levelNumber = GeneralVarsScript.levelNumber + 1
			print("level number " + str(GeneralVarsScript.levelNumber))
			if (GeneralVarsScript.levelNumber > 12):
				GeneralVarsScript.levelNumber = 12
			GeneralVarsScript.isCountingScore = false
			GeneralVarsScript.canFire = true
			#here we call the function itself so it loops after the previous round finishes
			enemySpawnLoop()

#the code for the enemy spawning loop with a boss fight
func bossFightEnemySpawnLoop():
	'''
	this is the boss enemy spawn loop which breaks when the player's 
	dead, otherwise it spawns something and then waits a 
	small second to spawn another enemy. However it will keep 
	spawning enemies until the boss head is dead.
	'''
	
	#this spawns a boss to move towards the player during the enemy spawning
	drHandmanSpawn()
	
	#this variable is used to help increment enemy spawning
	var i = 0
	
	#then we have a while loop that breaks when the boss' health is not above 0
	while (GeneralVarsScript.drHandmanHealth > 0):
		i = i + 1
		'''
		if on this quick second the player's dead, the game
		clears all the enemies and blood refills so they don't
		trigger another game over and break the for loop of
		spawning.
		'''
		if GeneralVarsScript.isDead or GeneralVarsScript.whoKilledMC != "no one":
			if (GeneralVarsScript.whoKilledMC == "manster"):
				GeneralVarsScript.whoKilledMC = "no one"
				print("manster rip out")
			for currentEnemy in $EnemyLayer.get_children():
				currentEnemy.queue_free()
			break
		'''
		Here on each quick second that's equal to one second,
		we use rng to spawn either a refill, or an enemy.
		'''
		if (i % 20 == 0):
			print(i)
			var rng = RandomNumberGenerator.new()
			var spawnType = rng.randi_range(1, 6)
			if (spawnType == 1):
				'''
				this spawns a health refill,
				that being a bloody pumpkin.
				'''
				pumpkinSpawn()
			else:
				'''
				if we're spawning an enemy, we randomly choose
				if it's a simpleWalker, a man monster guy, or a strange ASTHETICALLY
				glitched enemy.
				'''
				var enemyRng = RandomNumberGenerator.new()
				var enemyType = enemyRng.randi_range(1, GeneralVarsScript.levelNumber)
				print(enemyType)
				if (enemyType <= 3):
					simpleWalkEnemySpawn()
				elif (enemyType >= 4 and enemyType <= 7):
					batSpawn()
				elif (enemyType >= 8):
					glitchManSpawn()
					
		#We now wait a quick second.
		await get_tree().create_timer(0.075).timeout

#the code for the game over cutscene
func gameOverSequence():
	$BloodLabel.visible = false
	$Control/BloodMeter.visible = false
	GeneralVarsScript.isDead = true
	GeneralVarsScript.glitchTriggerCount = 0
	GeneralVarsScript.rushDirection = 0
	$Bgmusic8Bit.stop()
	$handmanBgMusic.stop()
	#this is how we get the death cutscene, where depending on
	#the value of whoKilledMC, it triggers the cutscene of the 
	#respective monster.
	if (GeneralVarsScript.whoKilledMC == "bear"):
		$MurderBearSprite.position = $CharacterBody2D/mcSprite.position + Vector2(25, 0)
		$MurderBearSprite.play("bear_rip_out_guts")
		print("bear frickin killing dude like jeez")
		await get_tree().create_timer(7.0/3.0).timeout
		$MurderBearSprite/Damaged8Bit.play()
		await get_tree().create_timer(8.0/5.0).timeout
		$MurderBearSprite.play("bear_guts_idle")
	elif (GeneralVarsScript.whoKilledMC == "manster"):
		$MurderMansterSprite.position = $CharacterBody2D/mcSprite.position + Vector2(-25, 0)
		$MurderMansterSprite.play("manster_ripping_flesh")
		await get_tree().create_timer(7.0/3.0).timeout
		$MurderMansterSprite/Damaged8Bit.play()
		await get_tree().create_timer(8.0/5.0).timeout
		$MurderMansterSprite.play("manster_flesh_idle")
	elif (GeneralVarsScript.whoKilledMC == "bat"):
		$MurderBatSprite.position = $CharacterBody2D/mcSprite.position + Vector2(0, -5)
		$MurderBatSprite.play("bat_ripping_flesh")
		await get_tree().create_timer(7.0/3.0).timeout
		$MurderBatSprite/Damaged8Bit.play()
		$MurderBatSprite.position = $MurderBatSprite.position + Vector2(0, -30)
		await get_tree().create_timer(8.0/5.0).timeout
		$MurderBatSprite.play("bat_flesh_idle")
		$MurderBatSprite.position = $MurderBatSprite.position + Vector2(0, 10)
	
	#we then deduct one life and update the lives counter
	GeneralVarsScript.livesCount = GeneralVarsScript.livesCount - 1
	$LivesAmount.text = str("X" + str(GeneralVarsScript.livesCount))
	
	#then we check if the player still has lives, and display a specific message
	if (GeneralVarsScript.livesCount <= 0):
		$TitleLabel.text = "GAME OVER"
	else:
		$TitleLabel.text = "YOU DIED"
	
	#we reset whoKilledMC and put the player in the game over state
	GeneralVarsScript.whoKilledMC = "no one"
	$TitleLabel.visible = true
	$Damaged8Bit.play()
	await get_tree().create_timer(1).timeout
	GeneralVarsScript.canFire = true
	GeneralVarsScript.gameStarted = false
	$InsertCoinLabel.visible = true
	$InsertCoinLabel.text = "CONTINUE"
	
	#here we do a countdown if the player got a game over
	if (GeneralVarsScript.livesCount <= 0):
		for i in range(11):
			$InsertCoinLabel.text = "INSERT COIN (" + str(10 - i) + ")"
			await get_tree().create_timer(0.5).timeout
		
		#if they still haven't pressed continue we pull up the highscore board for them to enter their highscore
		if not GeneralVarsScript.gameStarted:
			$HighscoreBoard.visible = true
			GeneralVarsScript.isEnteringNickname = true
			$InsertCoinLabel.text = "ENTER SCORE NAME"
			$TitleLabel.text = "HIGHSCORES"
			$Damaged8Bit.play()

#the code for what happens when a game starts
func _process(_delta):
	#this constantly checks if the player should be dead according to different things
	if (GeneralVarsScript.bulletCount <= 0 and GeneralVarsScript.isDead == false or GeneralVarsScript.whoKilledMC != "no one"):
		gameOverSequence()
	
	#otherwise we do these things when the player presses the fire button to start or to shoot
	if (Input.is_key_pressed(KEY_ENTER)):
		if (not GeneralVarsScript.gameStarted and not GeneralVarsScript.isEnteringNickname):
			#if a new game needs to start we do all this
			$PixelTreeSprite.frame = 1
			$PixelTreeSprite2.frame = 1
			$PixelTreeSprite3.frame = 1
			$PixelTreeSprite5.frame = 1
			$PixelTreeSprite6.frame = 1
			$PixelTreeSprite7.frame = 1
			$BigMedal.visible = false
			$LivesAmount.visible = true
			$BloodGuyLivesIcon.visible = true
			$Node2D.visible = false
			$TitleLabel.visible = false
			$InsertCoinLabel.visible = false
			$LevelLabel.visible = true
			$BloodLabel.visible = true
			$CharacterBody2D/mcSprite.frame = 1
			$CharacterBody2D/mcSprite.visible = true
			$MurderBatSprite.stop()
			$MurderBearSprite.stop()
			$MurderMansterSprite.stop()
			$MurderBatSprite.position = Vector2(1500, 1500)
			$MurderBearSprite.position = Vector2(1500, 1500)
			$MurderMansterSprite.position = Vector2(1500, 1500)
			$Control/BloodMeter.visible = true
			$HighscoreBoard.visible = false
			GeneralVarsScript.drHandmanDirection = 0
			GeneralVarsScript.drHandmanTriggerCount = 0
			GeneralVarsScript.drHandmanHealth = 32
			GeneralVarsScript.DrHandmanHitCombo = 0
			#and if the player has zero lives, we reset certain variables back to their start values
			if (GeneralVarsScript.livesCount <= 0):
				finalBossScoreRequirement = 20000
				GeneralVarsScript.scoreNumber = 0
				GeneralVarsScript.levelNumber = 0
				GeneralVarsScript.livesCount = 3
				$LivesAmount.text = str("X" + str(GeneralVarsScript.livesCount))
			GeneralVarsScript.bulletCount = 40
			$Control/BloodMeter.scale = Vector2(1, 1)
			$Bgmusic8Bit.play()
			
			$ShootBullet8Bit.play()
			GeneralVarsScript.gameStarted = true
			GeneralVarsScript.isDead = false
			GeneralVarsScript.canFire = true
			GeneralVarsScript.isEnteringNickname = false
			GeneralVarsScript.isCountingScore = false
			
			#here if the player reached we call the enemy spawning loop
			if (GeneralVarsScript.scoreNumber >= finalBossScoreRequirement):
				drHandmanSpawn()
			else:
				enemySpawnLoop()
		if (not GeneralVarsScript.isDead and GeneralVarsScript.gameStarted):
			if GeneralVarsScript.canFire and not GeneralVarsScript.isCountingScore and not GeneralVarsScript.isEnteringNickname:
				fire()
