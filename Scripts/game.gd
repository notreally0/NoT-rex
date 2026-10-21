extends Node2D

var score : int
var speed : float
var screen_size : Vector2i

const DINO_START_POS := Vector2i(150,485)
const CAM_START_POS := Vector2i(576, 324)
const START_SPEED :int = 10
const MAX_SPEED :int = 25


func _ready():
	screen_size = get_window().size
	new_game()

func new_game():
	score = 0
	$Dino.position = DINO_START_POS
	$Dino.velocity = Vector2i(0, 0)
	$Camera2D.position =CAM_START_POS
	$Ground.position = Vector2i(0, 0)


func _process(delta):
	speed = START_SPEED
	$Dino.position.x += speed
	$Camera2D.position.x += speed
	
	score += speed 
	print(score)
	
	if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
		$Ground.position.x += screen_size.x
