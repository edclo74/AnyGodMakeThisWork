extends CharacterBody2D
var is_ready: bool = true
@export var SPEED = 100.0
@export var ACCELERATION = 300.0
@export var FRICTION = 300.0
#@onready var Sprite = $AnimatedSprite2D
@onready var world = get_node('/root/World')
@onready var cooldown_timer = $Shoot_Timer
@onready var Sprite = $AnimationTree.get("parameters/playback")
@onready var animated_sprite_2d = $AnimatedSprite2D

var direction = Vector2.ZERO

func _ready():
	$AnimationTree.active = true
func _physics_process(delta):
		var shoot = Input.is_action_pressed("shoot") 
		var run = Input.is_action_pressed("run")
		#Movement
		direction = Input.get_vector("left", "right", "up", "down").normalized()
		if direction and run:
			velocity = velocity.move_toward(direction * SPEED * 2, ACCELERATION)
			Sprite.travel("Running") 
		elif direction:
			velocity = velocity.move_toward(direction * SPEED, ACCELERATION)
			Sprite.travel("Walking")
		else:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
			Sprite.travel("Idle")
		
		if velocity.x > 0:
			animated_sprite_2d.flip_h = true
		elif velocity.x < 0:
			animated_sprite_2d.flip_h = false
	
	#Shoot Mechanics
		
		if Input.is_action_just_pressed("shoot") and is_ready:
			$Shoot_Timer.start()
			is_ready = false
			Sprite.travel("Shoot")
		else:
			pass
func _on_shoot_timer_timeout():
	is_ready = true

func _process(delta):
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	
	
	
	move_and_slide()
	







