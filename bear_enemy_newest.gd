'''
Coded by Tanishq Chigullarevu
2026
'''
extends CharacterBody2D

'''
This is the script for the bear object itself, where we
most handle its animations.
'''

#when it detects its hitbox hit the player, we delete the bear, empty the bullet count, and set the whoKilledMC value to the bear to be used to play the death animation
func _on_area_2d_body_entered(body):
	if body.is_in_group("mc_guy") and GeneralVarsScript.isDead == false:
		GeneralVarsScript.whoKilledMC = "bear"
		GeneralVarsScript.bulletCount = 0
		$bearSprite.stop()
		queue_free()

#here when the enemy is loaded in, we play the walking animation
func _on_bear_sprite_ready():
	$bearSprite.play("bear_walkin_here")
