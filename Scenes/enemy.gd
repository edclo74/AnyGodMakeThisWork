extends Node2D
@export var speed = 0.2
var is_ready: bool = true
@onready var enemy_health = 3
var mouse_over = false
@onready var cooldown_timer = $Shoot_Timer
@onready var oof = $AudioStreamPlayer2D
@onready var animator = $Path2D/PathFollow2D/Area2D/AnimatedSprite2D
@onready var death = $death
var dead = false
@onready var detection_area = $Path2D/PathFollow2D/Area2D/DetectionArea
func hit():
	enemy_health -=1
	oof.play()
	
func _process(delta):
	if dead:return
	$Path2D/PathFollow2D.progress_ratio += speed * delta
	#if Input.is_action_just_pressed("shoot") and is_ready and mouse_over == true:
		#$Shoot_Timer.start()
		#enemy_health -= 1
		#is_ready = false
		#oof.play()
		

	if enemy_health == 0:
		dead = true
		animator.play("dead")
		death.play()
		speed = 0

	else:
		pass
	
	var detected = detection_area.get_overlapping_bodies()
	for body in detected:
		if body.is_in_group("Player"):
			pass


func _on_area_2d_mouse_entered():
	mouse_over = true



func _on_area_2d_mouse_exited():
	mouse_over = false




func _on_shoot_timer_timeout():
	is_ready = true
