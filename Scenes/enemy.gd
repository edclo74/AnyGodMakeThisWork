extends CharacterBody2D
@onready var player = get_tree().get_first_node_in_group("Player")

@export var SPEED = 100
var is_ready: bool = true
@onready var enemy_health = 3
var mouse_over = false
@onready var cooldown_timer = $Shoot_Timer
@onready var oof = $AudioStreamPlayer2D
@onready var animator = $Area2D/AnimatedSprite2D
@onready var death = $death
var dead = false
var can_see = false
@onready var detection_area = $Area2D/DetectionArea
func hit():
	enemy_health -=1
	oof.play()
	

func _physics_process(delta):
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if can_see:
		shoot()
	else:
		var direction_to_player = global_position.direction_to(player.global_position)
		velocity = direction_to_player * SPEED
		if dead == true:
			pass
		else:
			look_at(player.global_position)
			
		move_and_slide()

func shoot():
	pass

func _process(delta):
	if dead:return
	#$Path2D/PathFollow2D.progress_ratio += speed * delta
	#if Input.is_action_just_pressed("shoot") and is_ready and mouse_over == true:
		#$Shoot_Timer.start()
		#enemy_health -= 1
		#is_ready = false
		#oof.play()
		

	if enemy_health == 0:
		dead = true
		animator.play("dead")
		death.play()
		SPEED = 0
		await animator.animation_finished
		queue_free()
		#speed = 0
	else:
		pass
	

	
	




func _on_area_2d_mouse_entered():
	mouse_over = true



func _on_area_2d_mouse_exited():
	mouse_over = false




func _on_shoot_timer_timeout():
	is_ready = true


func _on_detection_area_body_entered(body):
	can_see= true




func _on_detection_area_body_exited(body):
	can_see = false # Replace with function body.
