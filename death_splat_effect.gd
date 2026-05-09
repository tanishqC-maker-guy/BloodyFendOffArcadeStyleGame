'''
Coded by Tanishq Chigullarevu
2026
'''
extends AnimatedSprite2D

'''
This is the script for the death splat object itself, where we
most handle its animation.
'''

#when the enemy splat sprite is loaded in for an enemy death, it plays and then deletes itself
func _on_ready():
	self.play("splat_anim")
	await get_tree().create_timer(2).timeout
	self.queue_free()
