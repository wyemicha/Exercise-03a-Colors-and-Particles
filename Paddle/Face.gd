extends Node2D

onready var HUD = get_node("/root/Game/HUD")
onready var center = get_viewport_rect().size.x/2
onready var height = get_viewport_rect().size.y


func _ready():
	HUD.connect("changed",self,"_on_HUD_changed")
	show_face()

func _physics_process(_delta):
	if get_node("/root/Game/Ball_Container").has_node("Ball"):
		pass
	else:
		pass
		

func show_face():
	if HUD.paddle_face:
		show()
	else:
		hide()


func _on_HUD_changed():
	show_face()
