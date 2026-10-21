extends Node2D

var score : float
var speed : float
var screen_size : Vector2
var game_running : bool

const DINO_START_POS := Vector2(150,485)
const CAM_START_POS := Vector2(576, 324)
const START_SPEED :int = 600
const MAX_SPEED :int = 1500
const SCORE_MODIFIER :int = 10.0


func _ready():
	screen_size = get_window().size
	new_game()

func new_game():
	score = 0
	speed = START_SPEED
	$Dino.position = DINO_START_POS
	$Dino.velocity = Vector2(0, 0)
	$Camera2D.position =CAM_START_POS
	$Ground.position = Vector2(0, 0)
	$HUD.get_node("StartLabel").show()


func _process(delta):
	if game_running:
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
		
func show_score():
	$HUD.get_node("ScoreLabel").text = "SCORE:" + str(int(score / SCORE_MODIFIER))
