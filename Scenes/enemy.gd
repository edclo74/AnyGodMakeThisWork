extends Node2D
@export var speed = 0.2




func _process(delta):
	$Path2D/PathFollow2D.progress_ratio += speed * delta


func _on_area_2d_mouse_entered():
	if Input.is_action_just_pressed("shoot"):
		get_tree().quit()
	else:
		pass
