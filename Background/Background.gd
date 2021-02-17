extends ColorRect

onready var HUD = get_node("/root/Game/HUD")
var c = 0
var colors = [
]

func _ready():
	HUD.connect("changed",self,"_on_HUD_changed")
	update_color()

func _on_HUD_changed():
	update_color()

func _on_Timer_timeout():
	if HUD.color_background:
		c = wrapi(c+1, 0, colors.size())
		update_color()


func update_color():
	pass
