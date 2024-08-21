extends Node2D

# Preload Collectables
const bottle = preload("res://Bottle.tscn")
const cigarrete = preload("res://cigarillo.tscn")
const can = preload("res://latitaPro8000.tscn")

const coll_types := [bottle, cigarrete, can]

var parent_node

var spawners := []

const time_between_collectable := 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent()
	for spawner in self.get_children():
		if spawner is Area2D:
			spawners.append(spawner)
			
	print(spawners)
	pass # Replace with function body.


func _on_timer_timeout():
	print("timer out")
	var index_collectable = randi_range(0, coll_types.size() - 1)
	var index_pos = randi_range(0, spawners.size() - 1)

	var item = coll_types[index_collectable].instantiate()
	
	
	item.scale = Vector2(1, 1)
	
	item.reparent(spawners[index_pos], false)
	
	parent_node.add_child(item)
	pass # Replace with function body.
