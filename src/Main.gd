extends Node2D

var Enemy = preload("res://src/Enemy.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var enemy = Enemy.instance()
	enemy.setup($SpawnPoint2.global_position, 0)
	add_child(enemy)
#	enemy.get_node("AnimatedSprite").play("Spawn")
#	enemy.get_node("SpawnTimer").start(3.0)
	enemy.get_node("ShootTimer").start(3.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
