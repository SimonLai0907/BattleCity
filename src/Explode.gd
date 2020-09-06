extends AnimatedSprite


func setup(pos):
	position = pos
	play()


func _on_animation_finished():
	queue_free()
