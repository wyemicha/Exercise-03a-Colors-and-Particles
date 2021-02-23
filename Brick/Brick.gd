extends KinematicBody2D

onready var HUD = get_node("/root/Game/HUD")
onready var target_y = position.y

var row = 0
var col = 0

export var appear_speed = 3
export var fall_speed = 1.0

var dying = false

var colors = [
	Color8(249,49,49),
	Color8(253, 126,20),
	Color8(255, 224,102),
	Color8(148, 216,45),
	Color8(34, 139,230),
	Color8(190, 75,219),
	Color8(132, 94, 247)
	
	
]
onready var textures = [
	load("res://Assets/smoke0.png")
	,load("res://Assets/smoke1.png")
	,load("res://Assets/smoke2.png")
	,load("res://Assets/smoke3.png")
]

func _ready():
	randomize()
	HUD.connect("changed",self,"_on_HUD_changed")
	update_color()

func _process(_delta):
	if dying:
		queue_free()

func start_brick():
	position = Vector2(position.x,target_y)

func _on_HUD_changed():
	update_color()


func die():
	dying = true
	var target_color = $Color.color
	target_color.a = 0
	$Color.color = target_color
	collision_layer = 0
	collision_mask = 0


func update_color():
	if HUD.color_blocks:
		if row >= 0 and row < colors.size():
			$Color.color = colors[row]
	else:
		$Color.color = Color(1,1,1,1)

func emit_particle(pos):
	if HUD.particle_blocks:
		$Particles2D.texture = textures[randi() % textures.size()]
		$Particles2D.emitting = true
		$Particles2D.global_position = pos

		
