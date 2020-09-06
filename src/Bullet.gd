extends RigidBody2D

export var Speed = 600
export var Explode: PackedScene
signal destroy


func setup(side, startpos, direction):
	set_collision_mask_bit(side, true)
	print("Add Bullet(mask bit %d)" % side)
	position = startpos
	linear_velocity = Vector2(cos(direction) * Speed, sin(direction) * Speed)
	rotation = direction
	print(rotation)


func find_direction():
	if rotation >= -PI / 4 and rotation < PI / 4:
		return 5
	if rotation >= PI / 4 and rotation < PI * 3 / 4:
		return 6
	if rotation >= PI * 3 / 4 or rotation < -PI * 3 / 4:
		return 7
	if rotation >= -PI * 3 / 4 and rotation < -PI / 4:
		return 8


func collide_point(Pt, body):
	var Index = body.get_cellv(Pt)
	print("Tile index = %d" % Index)
	if Index == 0:
		body.set_cell(Pt.x, Pt.y, find_direction())
	elif Index == 2:
		body.set_cell(Pt.x, Pt.y, 3)
	elif Index >= 5 and Index <= 8:
		body.set_cell(Pt.x, Pt.y, -1)


func _on_body_entered(body):
	print("collide with %s" % body.get_name())
	emit_signal("destroy")
	var explode = Explode.instance()
	queue_free()
	if body.get_class() == "Tank" and body.Invincible == false:
		print(body.get_class())
		body.queue_free()
		explode.setup(body.position)
		get_parent().add_child(explode)
		explode.play("Big")
	else:
		explode.setup(position)
		get_parent().add_child(explode)
		if body is TileMap:
			var MapPosTL = body.world_to_map($PointTopLeft.global_position)
			collide_point(MapPosTL, body)
			var MapPosTR = body.world_to_map($PointTopRight.global_position)
			collide_point(MapPosTR, body)
			var MapPosBL = body.world_to_map($PointBottomLeft.global_position)
			collide_point(MapPosBL, body)
			var MapPosBR = body.world_to_map($PointBottomRight.global_position)
			collide_point(MapPosBR, body)
