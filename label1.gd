extends CanvasLayer

func game_not_running() :
	var main_node = get_parent() 
	if main_node.game_start == true :
		queue_free()
