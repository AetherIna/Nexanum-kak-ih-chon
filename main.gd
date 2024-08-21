extends Node

#Position setter.
var bottle = preload("res://Bottle.tscn")

var cigarrete = preload("res://cigarillo.tscn")

var can = preload("res://latitaPro8000.tscn")


const CHARACTER_STARTING_POS = Vector2i(150, 450)
const CAM_START_POS = Vector2i(576, 324)

var coll_types := [bottle, cigarrete, can]

var screen_size : Vector2i
#Speed values.
var score : int
var goal = 100
var trash_collected : int
var speed : float
const START_SPEED : float = 1.0
const MAX_SPEED : int = 2

var ground_height : int
var collectables : Array
var last_coll
var game_start : bool

func new_game():
	score = 0
	$CHT.position = CHARACTER_STARTING_POS
	$CHT.velocity = Vector2i(0,0)
	$Camera2D.position = CAM_START_POS
	$Ground.position = Vector2i(0,0)
	
	for coll in collectables:
		coll.queue_free()
	collectables.clear()


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_start == true :
		speed = START_SPEED
		
		if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
			$Ground.position.x += screen_size.x
		
		#generate_coll()
		
		$CHT.position.x += speed
		$Camera2D.position.x += speed
		
	else:
		if Input.is_action_pressed("ui_accept"):
			game_start = true
			$Tut.game_not_running()
	
	
func generate_coll():
	#generate ground coll
	if collectables.is_empty() or last_coll.position.x < score + randi_range(300, 800):
		print("pass the if statement")
		var coll_type = coll_types[randi() % coll_types.size()]
		print(coll_type)
		var coll
		var max_coll = 1000
		for i in range(randi() % max_coll + goal * 1):
			coll = coll_type.instantiate()
			if coll != null:
				coll.scale = Vector2(0.5, 0.5) 
			
			# Position X to avoid overlap
			var coll_x : int = screen_size.x + score + randi_range(300, 500)
			if last_coll:
				coll_x = last_coll.position.x + last_coll.get_node("Sprite2D").texture.get_width() * last_coll.scale.x + randi_range(100, 300)
			
			var coll_height = coll.get_node("Sprite2D").texture.get_height()
			var coll_scale = coll.get_node("Sprite2D").scale
			var coll_y : int = screen_size.y - ground_height - (coll_height * coll_scale.y / 50) + 250
			last_coll = coll
			add_coll(coll, coll_x, coll_y)	
		
func add_coll(coll, x, y):
	coll.position = Vector2i(x, y)
	add_child(coll)
	collectables.append(coll)
		
			
			
func update_score(sc):
			score += sc
			$HUD.get_node("Score").text = "PUNTOS:" + str(score)
			
func update_trash(t):
			trash_collected += t
			$HUD.get_node("Trash").text = "BASURA:" + str(trash_collected)


func win():
	if trash_collected == goal :
		$CHT/AnimatedSprite2D.play("End")
		game_start = false
	



