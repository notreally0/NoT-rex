extends Node2D

const DINO_START_POS := Vector2i(150,485)
const CAM_START_POS := Vector2i(576, 324)

var speed : float
const START_SPEED :int = 25

func new_game():
	$Dino.position = DINO_START_POS
	$Dino.velocity = Vector2i(0, 0)
	$Camera2D.position =CAM_START_POS
	$Ground.position = Vector2i(0, 0)
