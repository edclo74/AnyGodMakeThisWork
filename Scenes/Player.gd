extends CharacterBody2D

@export var SPEED = 100.0
@export var ACCELERATION = 300.0
@export var FRICTION = 300.0
@onready var Sprite = $AnimatedSprite2D
@onready var world = get_node('/root/World')
@onready var cooldown_timer = $Shoot_Timer
var direction = Vector2.ZERO
func _physics_process(delta):

		
		var run = Input.is_action_pressed("run")
		#Movement
		direction = Input.get_vector("left", "right", "up", "down").normalized()

		if direction and run:
			velocity = velocity.move_toward(direction * SPEED * 2, ACCELERATION)
			Sprite.play("Running") 
		elif direction:
			velocity = velocity.move_toward(direction * SPEED, ACCELERATION)
			Sprite.play("Walking")
		else:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
			Sprite.play("Idle")
		
		if velocity.x > 0:
			Sprite.flip_h = true
		elif velocity.x < 0:
			Sprite.flip_h = false
	
	#Shoot Mechanics
		var shoot = Input.is_action_pressed("shoot")
		if shoot:
			Sprite.play("Shoot")
			
		else:
			pass

func _process(delta):
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	
	
	
	move_and_slide()
	

