extends KinematicBody2D

class_name Tank

var Bullet = preload("res://src/Bullet.tscn")
export var Speed = 150
export var Type = 0
var ChangeDirection = false
var MoveDirection = PI / 2
var Animation = ""
export var MaxAmmo = 1
var Ammo = 1
var CollisionMask = 0
var Invincible = false


func get_class():
	return "Tank"


func _ready():
	pass


func move_direction(direction):
	var velocity = Vector2(0, 0)
	if Animation != direction and direction != "":
		Animation = direction
		snap_to_grid()
	else:
		Animation = direction

	if Animation == "Up":
		MoveDirection = -PI / 2
	if Animation == "Down":
		MoveDirection = PI / 2
	if Animation == "Left":
		MoveDirection = PI
	if Animation == "Right":
		MoveDirection = 0.0

	if Animation != "":
		$AnimatedSprite.play("%d%s" % [Type, Animation])
		$Cannon.position = Vector2(cos(MoveDirection) * 32, sin(MoveDirection) * 32)
		velocity = move_and_slide(Vector2(cos(MoveDirection) * Speed, sin(MoveDirection) * Speed))
	else:
		$AnimatedSprite.stop()
#	print(velocity)
	if velocity.length() <= 0.5:
		ChangeDirection = true
		print("Change direction")


func snap_to_grid():
	print("Snap to Grid")
	var Grid = 32
	var RoundX = int(position.x) % Grid
	var RoundY = int(position.y) % Grid
#	if (Animation == "Up" or Animation == "Down") and ((RoundX < Grid/3) or (RoundX > Grid*2/3)):
	if Animation == "Up" or Animation == "Down":
		print("position.x = %d" % int(position.x))
		print("RoundX = %d" % RoundX)
		position.x = round(position.x / Grid) * Grid
		print("Set X to %d" % position.x)
#	if (Animation == "Right" or Animation == "Left") and (RoundY < Grid/3) or (RoundY > Grid*2/3):
	if Animation == "Right" or Animation == "Left":
		print("position.y = %d" % int(position.y))
		print("RoundY = %d" % RoundY)
		position.y = round(position.y / Grid) * Grid
		print("Set Y to %d" % position.y)


func shoot():
	Ammo -= 1
	var bullet = Bullet.instance()
	bullet.setup(1 - CollisionMask, $Cannon.global_position, MoveDirection)
	get_parent().add_child(bullet)
	bullet.connect("destroy", self, "ammo_recover")


func ammo_recover():
	if Ammo < MaxAmmo:
		Ammo += 1
