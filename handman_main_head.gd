'''
Coded by Tanishq Chigullarevu
2026
'''
extends CharacterBody2D

'''
This is the script for the dr Handman object itself, where we
most handle its animations.
'''

#This is a variable we use to check when the dr Handman has been attacked, which we set to its health value
var internalDrHandmanHealth = GeneralVarsScript.drHandmanHealth
'''
here when the enemy is loaded in, we play its death animation
if all its health has been depleted, otherwise we play its
appear animation.
'''
func _on_animated_sprite_2d_ready():
	if (GeneralVarsScript.drHandmanHealth > 0):
		$AnimatedSprite2D.play("handman_reveal")
		await get_tree().create_timer(4.15).timeout
		$AnimatedSprite2D.play("handman_moving_forward")
	else:
		$AnimatedSprite2D.play("handman_dying_so_sad")

#when it detects its hitbox hit the player, we delete the dr Handman, empty the bullet count, and set the whoKilledMC value to drHandman to be used to play the death animation
func _on_area_2d_body_entered(body):
	if (body.is_in_group("mc_guy") and GeneralVarsScript.isDead == false):
		GeneralVarsScript.whoKilledMC = "drHandman"
		GeneralVarsScript.bulletCount = 0
		$AnimatedSprite2D.stop()
		queue_free()


func _process(_delta):
	#here we see if the guy has been hit, we set internalDrHandmanHealth to the current health 
	if (GeneralVarsScript.drHandmanHealth < internalDrHandmanHealth):
		internalDrHandmanHealth = GeneralVarsScript.drHandmanHealth
		'''
		then check how many times in a row the guy has been hit.
		If less than 4, we just play a damaged animation. If it's been hit
		4 times, we then have it in a frozen state of damaged to show it's
		going back.
		'''
		if (GeneralVarsScript.DrHandmanHitCombo <= 3 and GeneralVarsScript.drHandmanHealth != 0):
			if $Damaged8Bit:
				$Damaged8Bit.play()
			$AnimatedSprite2D.play("handman_damaged_forward")
			await get_tree().create_timer(0.2).timeout
			$AnimatedSprite2D.play("handman_moving_forward")
			GeneralVarsScript.DrHandmanHitCombo = GeneralVarsScript.DrHandmanHitCombo + 1
		if (GeneralVarsScript.DrHandmanHitCombo == 4 and GeneralVarsScript.drHandmanHealth != 0):
			$AnimatedSprite2D.play("handman_damaged_forward")
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.frame = 0
