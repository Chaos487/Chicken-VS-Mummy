extends Control
@onready var start: Button = $MarginContainer/HBoxContainer/VBoxContainer/Start
@onready var quit: Button = $MarginContainer/HBoxContainer/VBoxContainer/Quit
@onready var game = preload ("res://scenes/Game/game.tscn") as PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void: #	
	$MarginContainer/HBoxContainer/VBoxContainer/Start.pressed.connect(_on_start_pressed)
	$MarginContainer/HBoxContainer/VBoxContainer/Quit.pressed.connect(_on_quit_pressed)

func _on_start_pressed():
	get_tree().change_scene_to_packed(game) 
func _on_quit_pressed():
	get_tree().quit()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
