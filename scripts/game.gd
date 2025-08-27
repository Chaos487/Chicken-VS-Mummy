extends Node2D


@onready var player: CharacterBody2D = $player
@onready var pause_menu: Control = $player/Camera2D/PauseMenu
@onready var gui: Control = $player/Camera2D/GUI
@onready var label: Label = $player/Camera2D/GUI/Label
@onready var killsum: Label = $Gameover/ColorRect/killsum
@onready var accuracysum: Label = $Gameover/ColorRect/accuracysum



var paused = false
var mummy_kill_count = 0  # 记录击杀的木乃伊数量
var kills_per_wave = 20  # 每波需要击杀的木乃伊数量
var spawn_enabled = true  # 控制是否继续生成木乃伊
var bullet_fired_count = 0  # 记录发射的子弹数量

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
	if Input.is_action_just_pressed("fire"):  # 记录每次按下射击按钮
		bullet_fired_count += 1
		
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused	

func spawn_mummy(): 
	if spawn_enabled:  # 检查是否允许生成
		var new_mummy = preload("res://scenes/Game/mummy.tscn").instantiate()
		%PathFollow2D.progress_ratio = randf()
		new_mummy.global_position = %PathFollow2D.global_position
		add_child(new_mummy)
	
		new_mummy.name = "mummy"  # 设置名称为 'mummy'
	
		if player and new_mummy.global_position.x < player.global_position.x:
			if new_mummy.has_node("AnimatedSprite2D"):
				new_mummy.get_node("AnimatedSprite2D").flip_h = true
			else:
				if new_mummy.has_node("AnimatedSprite2D"):
					new_mummy.get_node("AnimatedSprite2D").flip_h = false
					
		
func _on_timer_timeout() -> void:
	if spawn_enabled:
		spawn_mummy()

func _on_mummy_killed():
	mummy_kill_count += 1
	gui.update_kill_count(mummy_kill_count)  # 更新 GUI 中的击杀数量
	
	if mummy_kill_count % kills_per_wave == 0:
		# 每击杀 20 个木乃伊时显示消息
		show_message("More are coming!")
		
func _on_player_health_depleted() -> void:
	spawn_enabled = false
	$Timer.stop()
	%Gameover.visible = true
	Engine.time_scale = 0 
	
	

	# 计算命中率并显示统计信息
	var accuracy = 0.0
	if bullet_fired_count > 0:
		accuracy = float(mummy_kill_count) / bullet_fired_count * 100
	
	killsum.text = "Bullets Fired: " + str(bullet_fired_count) + "\n" + \
		"Mummies Killed: " + str(mummy_kill_count) + "\n" + \
		"Accuracy: %.2f%%" % accuracy 


func _on_restart_pressed() -> void:
	Engine.time_scale = 1  # 恢复游戏逻辑
	get_tree().reload_current_scene()  # 重载场景
	InputMap.action_add_event("fire", InputEventKey.new())  # 恢复射击输入

func show_message(message: String) -> void:
	# 显示消息在屏幕上
	label.text = message
	label.show()
	await get_tree().create_timer(2).timeout  # 等待 2 秒
	label.hide()
