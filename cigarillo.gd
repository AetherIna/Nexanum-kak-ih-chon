extends Area2D

func _on_body_entered(body):
	if body.name == "CHT":
		var main_node = get_parent()
		main_node.update_score(20)
		main_node.update_trash(20)
		queue_free()
