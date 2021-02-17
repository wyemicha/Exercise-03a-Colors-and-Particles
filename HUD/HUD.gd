extends Control

var color_paddle = false
var color_ball = false
var color_blocks = false
var color_background = false

var particle_paddle = false
var particle_walls = false
var particle_blocks = false
var particle_ball = false

var blocks_appear = false
var blocks_fall = false
var blocks_fade = false

var screen_shake_paddle = 0
var screen_shake_blocks = 0
var screen_shake_walls = 0
var ball_trail = false

var paddle_appear = false
var paddle_stretch = false
var paddle_face = false

var audio_music = false
var audio_effects = false

var effects_blur = false


signal changed

onready var WE = get_node_or_null("/root/Game/WorldEnvironment")

func _ready():
	reset_values()
	
func reset_values():
	color_paddle = false
	color_ball = false
	color_blocks = false
	color_background = false

	particle_paddle = false
	particle_walls = false
	particle_blocks = false
	particle_ball = false

	blocks_appear = false
	blocks_fall = false
	blocks_fade = false

	screen_shake_paddle = 0
	screen_shake_blocks = 0
	screen_shake_walls = 0
	ball_trail = false

	paddle_appear = false
	paddle_stretch = false
	paddle_face = false

	audio_music = false
	audio_effects = false

	effects_blur = false
	emit_signal("changed")
	set_UI()

func set_UI():
	$Menu/Color/Color_Paddle.pressed = color_paddle
	$Menu/Color/Color_Ball.pressed = color_ball
	$Menu/Color/Color_Blocks.pressed = color_blocks
	$Menu/Color/Color_Background.pressed = color_background

	$Menu/Particles/Particle_Paddle.pressed = particle_paddle
	$Menu/Particles/Particle_Blocks.pressed = particle_blocks
	$Menu/Particles/Particle_Walls.pressed = particle_walls
	$Menu/Particles/Particle_Ball.pressed = particle_ball


func _on_Reset_pressed():
	get_node("/root/Game/Bricks").start_bricks()
	get_node("/root/Game/Ball_Container").start_ball()
	get_node("/root/Game/Paddle_Container/Paddle").start_paddle()
	reset_values()
	get_tree().paused = false
	if WE != null:
		WE.show()
	hide()
	


func _on_Quit_pressed():
	get_tree().quit()




func _on_Color_Paddle_toggled(button_pressed):
	color_paddle = button_pressed
	emit_signal("changed")


func _on_Color_Ball_toggled(button_pressed):
	color_ball = button_pressed
	emit_signal("changed")


func _on_Color_Blocks_toggled(button_pressed):
	color_blocks = button_pressed
	emit_signal("changed")


func _on_Color_Background_toggled(button_pressed):
	color_background = button_pressed
	emit_signal("changed")


func _on_Particle_Paddle_toggled(button_pressed):
	particle_paddle = button_pressed
	emit_signal("changed")


func _on_Particle_Blocks_toggled(button_pressed):
	particle_blocks = button_pressed
	emit_signal("changed")


func _on_Particle_Walls_toggled(button_pressed):
	particle_walls = button_pressed
	emit_signal("changed")


func _on_Particle_Ball_toggled(button_pressed):
	particle_ball = button_pressed
	emit_signal("changed")
