extends Node2D

const bullet = preload("res://scenes/Game/bullet.tscn")
@onready var firemarker: Marker2D = $Marker2D
@onready var sfx_fire: AudioStreamPlayer2D = $sfx_fire

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_tree().paused:
		return
		
	look_at(get_global_mouse_position())

	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1 

	if Input.is_action_just_pressed("fire"):
		Global.camera.shake(0.2, 5)
		var bullet_instance = bullet.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = firemarker.global_position
		bullet_instance.rotation = rotation
		sfx_fire.play()
