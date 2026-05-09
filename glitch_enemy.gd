'''
Coded by Tanishq Chigullarevu
2026
'''
extends CharacterBody2D

'''
This is the script for the bat object itself, where we
most handle its animations.
'''

#when it detects its hitbox hit the player, we delete the glitch guy, empty the bullet count, and set the whoKilledMC value to the glitch guy to be used to play the death animation
func _on_area_2d_body_entered(body):
	if (body.is_in_group("mc_guy") and GeneralVarsScript.isDead == false):
		GeneralVarsScript.whoKilledMC = "glitch guy"
		GeneralVarsScript.bulletCount = 0
		$GlitchSprite.stop()
		queue_free()

'''
here when the enemy is loaded in, different things can happen depending on 
it's trigger count. If it's at the start of its life cycle, it will play an
 noise and we play the idle animation. When it's ready to attack, we play the
dashing animation depending on its direction according to GeneralVarsScript.rushDirection
'''
func _on_glitch_sprite_ready():
	$Damaged8Bit.play()
	if (GeneralVarsScript.rushDirection == 0):
		$GlitchSprite.play("idle_anim")
	elif (GeneralVarsScript.glitchTriggerCount == 7):
		$GlitchManScream.play()
		$GlitchManUnderlyingScream.play()
		if (GeneralVarsScript.rushDirection == 1):
			$GlitchSprite.play("rushing_anim_right")
		elif (GeneralVarsScript.rushDirection == 2):
			$GlitchSprite.play("rushing_anim_left")
		elif (GeneralVarsScript.rushDirection == 3):
			$GlitchSprite.play("rushing_anim_top")
		elif (GeneralVarsScript.rushDirection == 4):
			$GlitchSprite.play("rushing_anim_bottom")
