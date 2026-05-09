'''
Coded by Tanishq Chigullarevu
2026
'''
extends Node2D

'''
This is the script for the blood bullet, which handles its
functionality.
'''

#this handles how the blood bullets function
func _on_killzone_body_entered(body):
	#if they hit an object in the enemy group, we do all of this
	if body.is_in_group("smelly_enemy"):
		#delete the enemy...
		get_tree().queue_delete(body)
		#play the enemy death sound and skull animation...
		if $Damaged8Bit:
			$Damaged8Bit.play()
			$Damaged8Bit.reparent(get_tree().root)
		var bloodSplat = preload("res://death_splat_effect.tscn")
		var sentBloodSplat = bloodSplat.instantiate()
		add_child(sentBloodSplat)
		sentBloodSplat.position = $bloodBulletSprite.position
		sentBloodSplat.reparent(get_tree().root)
		#delete the bullet itself...
		queue_free()
		#and add 50 points to the score
		GeneralVarsScript.scoreNumber = GeneralVarsScript.scoreNumber + 50
	#if the bullet hits something labeled as a blood refill we do this
	elif body.is_in_group("blood_refills"):
		#delete the refill pumpkin
		get_tree().queue_delete(body)
		#...if the health refill sound effect still exists we play it and delete it
		if $HealthRefill8Bit:
			$HealthRefill8Bit.play()
			$HealthRefill8Bit.reparent(get_tree().root)
			queue_free()
			#and add 100 points to the score
			GeneralVarsScript.scoreNumber = GeneralVarsScript.scoreNumber + 100
			#because it's a refill of course we refill 5 bullets in the player arsenal, which doubles as health too
			GeneralVarsScript.bulletCount = GeneralVarsScript.bulletCount + 5
			#if the player's bullet count is over 40, we reset it back to 40
			if (GeneralVarsScript.bulletCount > 40):
				GeneralVarsScript.bulletCount = 40
	elif body.is_in_group("final_boss_main_head"):
		#delete the bullet itself...
		queue_free()
		
		if (GeneralVarsScript.DrHandmanHitCombo <= 3):
			# reduces health from Dr Handman's health
			GeneralVarsScript.drHandmanHealth = GeneralVarsScript.drHandmanHealth - 1
			#and add 50 points to the score
			GeneralVarsScript.scoreNumber = GeneralVarsScript.scoreNumber + 50
