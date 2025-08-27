extends Camera2D

var shake_amount : float = 0
var default_offset: Vector2 = offset
var pos_x: int
var pos_y: int

@onready var timer: Timer = $Timer
@onready var tween: Tween = create_tween()

var is_shaking = false  # 标记是否正在抖动

func _ready():
	set_process(true)
	Global.camera = self
	randomize()
	
func _physics_process(delta: float) -> void:
	if is_shaking:
		offset = Vector2(randf_range(-1,1) * shake_amount, randf_range(-1,1) * shake_amount)
	else:
		offset = default_offset
		
func shake(time:float, amount:float):
	if !is_shaking:  # 确保只执行一次
		timer.wait_time = time
		shake_amount = amount
		is_shaking = true  # 设置为抖动状态
		set_process(true)
		timer.start()
	
func _on_timer_timeout() -> void:
	is_shaking = false  # 停止抖动
	set_process(false)
	tween.interpolate_value(self, "offset", 1, 1, tween.TRANS_LINEAR,tween.EASE_IN)
