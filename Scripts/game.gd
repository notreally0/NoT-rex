extends Node2D

var stump_scene = preload("res://Scene/stump.tscn")
var rock_scene = preload("res://Scene/rock.tscn")
var barrel_scene = preload("res://Scene/barrel.tscn")
var bird_scene = preload("res://Scene/bird.tscn")
var obstacle_types := [stump_scene, rock_scene, barrel_scene]
var obstacles : Array
var bird_height := [200, 390]


var score : float
var speed : float
var screen_size : Vector2
var ground_height : int
var game_running : bool
var last_obs

const DINO_START_POS := Vector2(150,485)
const CAM_START_POS := Vector2(576, 324)
const START_SPEED :int = 600
const MAX_SPEED :int = 1500
const SCORE_MODIFIER :int = 10
const SPEED_MODIFIER :int = 5000


func _ready():
	$"8Bit".play()
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()
	
	
func new_game():
	score = 0
	show_score()
	speed = START_SPEED
	game_running = false
	$Dino.position = DINO_START_POS
	$Dino.velocity = Vector2(0, 0)
	$Camera2D.position =CAM_START_POS
	$Ground.position = Vector2(0, 0)
	$HUD.get_node("StartLabel").show()
	
func _process(delta):
	if game_running:
		speed = START_SPEED + score / SPEED_MODIFIER
		if speed > MAX_SPEED:
			speed = MAX_SPEED
		generate_orb()
			
		$Dino.position.x += speed * delta
		$Camera2D.position.x += speed * delta
		score += speed * delta
		show_score()
		
	if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
		$Ground.position.x += screen_size.x
	else:
		if Input.is_action_pressed("ui_accept"):
			game_running = true
			$HUD.get_node("StartLabel").hide()
			
func generate_orb():
	if obstacles.is_empty() or last_obs.position.x < score + randi_range(300,500):
		var obs_types = obstacle_types[randi() % obstacle_types.size()]
		var obs
		for i in range(1):
			obs = obs_types.instantiate()
			var obs_height = obs.get_node("Sprite2D").texture.get_height()
			var obs_scale = obs.get_node("Sprite2D").scale
			var obs_x : int = screen_size.x + score + 100 + (i * 100)
			var obs_y : int = screen_size.y - ground_height - (obs_height * obs_scale.y / 2 + 5)
			last_obs = obs
			add_obs(obs, obs_x, obs_y)
		
func add_obs(obs, x, y):
	obs.position = Vector2(x, y)
	add_child(obs)
	obstacles.append(obs)
	
func show_score():
	$HUD.get_node("ScoreLabel").text = "SCORE:" + str(int(score / SCORE_MODIFIER))
