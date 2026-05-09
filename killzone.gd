extends Area2D

func _on_body_entered(body):
	if body.is_in_group("smelly_enemy"):
		print("dead bad guy")
		get_tree().queue_delete(body)
		queue_free()
		$Damaged8Bit.play()
	if body.is_in_group("mc_guy"):
		print("you died")
