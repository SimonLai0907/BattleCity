extends Tank

func _ready():
	pass

func _physics_process(delta):
	if ChangeDirection == true:
		ChangeDirection = false
		move_direction(change_direction())
	else:
		move_direction(Animation)


func change_direction():
	var NewDirection = []
	if !$RayCastTopLeft.is_colliding() and !$RayCastTopRight.is_colliding():
		NewDirection.append("Up")
	if !$RayCastBottomLeft.is_colliding() and !$RayCastBottomRight.is_colliding():
		NewDirection.append("Down")
	if !$RayCastLeftTop.is_colliding() and !$RayCastLeftBottom.is_colliding():
		NewDirection.append("Left")
	if !$RayCastRightTop.is_colliding() and !$RayCastRightBottom.is_colliding():
		NewDirection.append("Right")
	if len(NewDirection) > 1:
		if Animation == "Up":
			NewDirection.erase("Down")
		if Animation == "Down":
			NewDirection.erase("Up")
		if Animation == "Left":
			NewDirection.erase("Right")
		if Animation == "Right":
			NewDirection.erase("Left")
	print(NewDirection)
	return NewDirection[randi() % len(NewDirection)]

func setup(startposition, type):
	position = startposition
	Type = type
	CollisionMask = 1


func ammo_recover():
	if Ammo < MaxAmmo:
		$ShootTimer.start(rand_range(0.5, 2.0))
		Ammo += 1


func _on_ShootTimer_timeout():
	shoot()


func _on_SpawnTimer_timeout():
	$AnimatedSprite.play("%d%s" % [Type, Animation])
	set_collision_layer_bit(1, true)
