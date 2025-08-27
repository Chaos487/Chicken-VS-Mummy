extends CharacterBody2D

signal health_depleted

const SPEED = 300.0

var health = 100
var processed_mummies = []

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var playerhurtbox: Area2D = $playerhurtbox


func _physics_process(delta: float) -> void:
	# 获取输入方向
	var direction = Vector2.ZERO
	if Input.is_action_pressed("moveright"):
		direction.x += 1 
	if Input.is_action_pressed("moveleft"):
		direction.x -= 1
	if Input.is_action_pressed("moveup"):
		direction.y -= 1
	if Input.is_action_pressed("movedown"):
		direction.y += 1
	direction = direction.normalized()
	
	if direction.x > 0:
		animated_sprite_2d.flip_h = false
	elif direction.x < 0:
		animated_sprite_2d.flip_h = true
	
	
	if direction == Vector2.ZERO:
		animated_sprite_2d.play("idle")  # 待机动画
	else:
		animated_sprite_2d.play("run")  # 移动动画
	
	velocity = direction * SPEED
	move_and_slide()
	

	var overlapping_bodies = %playerhurtbox.get_overlapping_bodies() 
	for body in overlapping_bodies:
		if body and body.name.contains("mummy") and not processed_mummies.has(body):
			$sfx_damage.play()
			health -= 20
			%playerhealth.value = health
			if health <= 0.0:
				health_depleted.emit()
			processed_mummies.append(body)
			body.queue_free()


			
