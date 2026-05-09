'''
Coded by Tanishq Chigullarevu
2026
'''
extends AnimatedSprite2D

'''
This is the script for the glitch enemy's arrow, this script
handles animations but also the number direction the glitch
enemy will charge in.
'''

#when the arrow that shows the player which way the glitch enemy will dash from spawns in, we do all of this.
func _on_ready():
	#we generate a random number between 1-4 to choose which direction to dash
	var rng = RandomNumberGenerator.new()
	var spawnType = rng.randi_range(1, 4)
	#play the arrow roulette animation...
	self.play("arrow_roulette")
	await get_tree().create_timer(1.8).timeout
	#when it finishes, stop it and set the displayed arrow to the one corrasponding to what direction was chosen...
	self.stop()
	self.frame = spawnType - 1
	#set the global variable for the glitch enemy's rush direction to the chosen direction...
	GeneralVarsScript.rushDirection = spawnType
	#play the sound effect to show it chose a direction...
	$ShootBullet8Bit.play()
	await get_tree().create_timer(3).timeout
	#and finally move out of sight where it then deletes itself.
	for i in range(6):
		self.position = self.position + Vector2(0, 42)
		await get_tree().create_timer(0.075).timeout
	self.queue_free()
