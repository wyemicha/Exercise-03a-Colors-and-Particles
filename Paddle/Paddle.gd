extends KinematicBody2D

onready var Ball = load("res://Ball/Ball.tscn")
onready var HUD = get_node("/root/Game/HUD")

export var speed = 30
onready var collision_transform = $CollisionShape2D.get_transform().get_scale()

onready var target_y = position.y

var color = Color8(173,181,189)
			


func _ready():
	randomize()
	HUD.connect("changed",self,"_on_HUD_changed")
	update_color()

func _physics_process(_delta):
	var target = get_viewport().get_mouse_position().x
	target = clamp(target, 0, get_viewport().size.x)

	var d = abs(target - position.x)						# distance between the mouse and the paddle
	var p = d / get_viewport().get_visible_rect().size.x	# percentage of the total viewport
	var t = clamp(d, d, speed)							# how much to move the paddle this cycle (maximum of speed)
	var s = sign(target - position.x)					# which direction to move
	
	position.x += s*t

func start_paddle():
	pass

func _on_HUD_changed():
	update_color()

func update_color():
	if HUD.color_paddle:
		$Color.color = color
	else:
		$Color.color = Color(1,1,1,1)

func emit_particle(pos):
	if HUD.particle_paddle:
		get_parent().find_node("Particles2D").global_position = pos
		get_parent().find_node("Particles2D").emitting = true
		get_parent().find_node("Particles2D").look_at(pos)
   
	
