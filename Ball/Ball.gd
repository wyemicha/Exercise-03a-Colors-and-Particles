extends RigidBody2D

export var max_speed = 400.0
export var min_speed = 100.0
onready var HUD = get_node("/root/Game/HUD")

var color = Color8(173,181,189)

func _ready():
	HUD.connect("changed",self,"_on_HUD_changed")
	contact_monitor = true
	set_max_contacts_reported(4)
	update_color()

func _on_HUD_changed():
	update_color()	

func _physics_process(_delta):
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.has_method("emit_particle"):
			body.emit_particle(global_position)
		if body.is_in_group("Brick"):
			body.die()

func _integrate_forces(state):
	if abs(state.linear_velocity.x) < min_speed:
		state.linear_velocity.x = sign(state.linear_velocity.x) * min_speed
	if abs(state.linear_velocity.y) < min_speed:
		state.linear_velocity.y = sign(state.linear_velocity.y) * min_speed
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity = state.linear_velocity.normalized() * max_speed

func update_color():
	if HUD.color_ball:
		$Color.color = color
	else:
		$Color.color = Color(1,1,1,1)
	if HUD.particle_ball:
		$Particles2D.emitting = true
	else:
		$Particles2D.emitting = false

