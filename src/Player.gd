extends Tank

#export var Bullet: PackedScene
#export var Speed = 15000
#export var Type = 0
#var MoveDirection = -PI / 2
#var Animation = ""
#export var MaxAmmo = 1
#var Ammo = 1

func _ready():
	set_invincible()

func _process(delta):
	if Input.is_action_just_pressed("ui_select") and Ammo > 0:
		shoot()

func _physics_process(delta):
	if Input.is_action_pressed("Up"):
		move_direction("Up")
#		Animation = "Up"
#		snap_to_grid()
#		MoveDirection = -PI / 2
	elif Input.is_action_pressed("Down"):
		move_direction("Down")
#		Animation = "Down"
#		snap_to_grid()
#		MoveDirection = PI / 2
	elif Input.is_action_pressed("Left"):
		move_direction("Left")
#		Animation = "Left"
#		snap_to_grid()
#		MoveDirection = PI
	elif Input.is_action_pressed("Right"):
		move_direction("Right")
#		Animation = "Right"
#		snap_to_grid()
#		MoveDirection = 0.0
	elif Input.is_action_just_released(Animation):
		move_direction("")
#		Animation = ""
#		$AnimatedSprite.stop()
#	if Animation != "":
#		$AnimatedSprite.play("%d%s" % [Type, Animation])
#		$Cannon.position = Vector2(cos(MoveDirection) * 32, sin(MoveDirection) * 32)
#		move_and_slide(Vector2(cos(MoveDirection) * Distance, sin(MoveDirection) * Distance))


#func shoot():
#	Ammo -= 1
#	var bullet = Bullet.instance()
#	bullet.setup(1, $Cannon.global_position, MoveDirection)
#	get_parent().add_child(bullet)
#	bullet.connect("destroy", self, "ammo_recover")


#func snap_to_grid():
#	print("Snap to Grid")
#	var Grid = 32
#	var RoundX = int(position.x) % Grid
#	var RoundY = int(position.y) % Grid
##	if (Animation == "Up" or Animation == "Down") and ((RoundX < Grid/3) or (RoundX > Grid*2/3)):
#	if Animation == "Up" or Animation == "Down":
#		print("position.x = %d" % int(position.x))
#		print("RoundX = %d" % RoundX)
#		position.x = round(position.x / Grid) * Grid
#		print("Set X to %d" % position.x)
##	if (Animation == "Right" or Animation == "Left") and (RoundY < Grid/3) or (RoundY > Grid*2/3):
#	if Animation == "Right" or Animation == "Left":
#		print("position.y = %d" % int(position.y))
#		print("RoundY = %d" % RoundY)
#		position.y = round(position.y / Grid) * Grid
#		print("Set Y to %d" % position.y)


#func ammo_recover():
#	if Ammo < MaxAmmo:
#		Ammo += 1

func set_invincible():
	Invincible = true
	$Effect.visible = true
	$InvincibleTimer.start(3.0)

func _on_Timer_timeout():
	$Effect.visible = false
	Invincible = false
