extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = $"../player"

const SPEED = 250

var health = 2


func _process(delta: float) -> void:
	var toPlayer = (player.position - position).normalized()
	velocity = toPlayer*SPEED
	move_and_slide()
	
func play_hurt():
	animated_sprite_2d.play("hurt")
	await animated_sprite_2d.animation_finished 
	animated_sprite_2d.play("run")  
	
func play_death():
	animated_sprite_2d.play("death")

func take_damage():
	health -= 1
	if health > 0:
		play_hurt()
	elif health == 0:
		if $mummyhurtbox.has_node("CollisionShape2D2"):
			$mummyhurtbox/CollisionShape2D2.call_deferred("set_disabled", true)
		play_death()
		
		if get_parent().has_method("_on_mummy_killed"):
			get_parent()._on_mummy_killed()
		
		await animated_sprite_2d.animation_finished 
		queue_free()
		set_process(false)
		

	
