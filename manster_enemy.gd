'''
Coded by Tanishq Chigullarevu
2026
'''
extends CharacterBody2D

'''
This is the script for the man monster object itself, where we
most handle its animations.
'''

#when it detects its hitbox hit the player, we delete the man monster, empty the bullet count, and set the whoKilledMC value to the man monster to be used to play the death animation
func _on_area_2d_body_entered(body):
	if body.is_in_group("mc_guy") and GeneralVarsScript.isDead == false:
		print("you died to a manster")
		GeneralVarsScript.whoKilledMC = "manster"
		GeneralVarsScript.bulletCount = 0
		$MansterSprite.stop()
		queue_free()

#here when the enemy is loaded in, we play the walking animation
func _on_manster_sprite_ready():
	$MansterSprite.play("manster_walkin_here")
