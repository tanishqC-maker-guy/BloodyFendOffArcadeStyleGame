'''
Coded by Tanishq Chigullarevu
2026
'''
extends CharacterBody2D

'''
This is the script for the bat object itself, where we
most handle its animations.
'''

#here when the enemy is loaded in, we play the flying animation
func _on_bat_sprite_ready():
	$BatSprite.play("bat_flying_here")

#when it detects its hitbox hit the player, we delete the bat, empty the bullet count, and set the whoKilledMC value to the bat to be used to play the death animation
func _on_area_2d_body_entered(body):
	if body.is_in_group("mc_guy") and GeneralVarsScript.isDead == false:
		GeneralVarsScript.whoKilledMC = "bat"
		GeneralVarsScript.bulletCount = 0
		$BatSprite.stop()
		queue_free()
