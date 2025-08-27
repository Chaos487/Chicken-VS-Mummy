extends Node2D

const SPEED: int = 3500

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body and body.is_inside_tree(): 
		if body.has_method("take_damage"):
			body.take_damage()
	
	
	
