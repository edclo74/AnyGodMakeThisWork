extends Node2D



func _on_area_2d_mouse_entered():
	if Input.is_action_just_pressed("shoot"):
		get_tree().quit()
	else:
		pass
