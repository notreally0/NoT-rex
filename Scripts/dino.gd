extends CharacterBody2D

const GRAVITY = 5400.0
const JUMP_SPEED = -1800.0
@onready var jump: AudioStreamPlayer = $Jump

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		if not get_parent().game_running:
			$AnimatedSprite2D.play("idle")
			move_and_slide()
			return
		else:
			$RunCollision.disabled = false
		if Input.is_action_pressed("ui_accept"):
			velocity.y = JUMP_SPEED
			jump.play()
		if Input.is_physical_key_pressed(KEY_S):
			$AnimatedSprite2D.play("duck")
			$RunCollision.disabled = true
		else :
			$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("jump")
			
	move_and_slide()
	
