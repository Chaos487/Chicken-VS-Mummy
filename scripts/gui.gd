extends Control
@onready var killcount: Label = $ui/killcount

# 更新击杀数量的方法
func update_kill_count(kill_count: int) -> void:
	killcount.text = "You Kill " + str(kill_count) + " Mummies"
