extends Control
@onready var game: Node2D = $"../../.."



func _on_resume_pressed() -> void:
	game.pauseMenu()
	 
func _on_quit_pressed() -> void:
	get_tree().quit()



	
