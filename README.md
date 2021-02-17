# Exercise-03a-Colors-and-Particles
Exercise for MSCH-C220, 17 February 2021

This exercise is designed to explore adding color and particle effects to a boring brick breaker game (in the spirit of "Juice it or Lose it").

Fork this repository. When that process has completed, make sure that the top of the repository reads [your username]/Exercise-03a-Color-and-Particles. *Edit the LICENSE and replace BL-MSCH-C220-S21 with your full name.* Commit your changes.

Clone the repository to a Local Path on your computer.

Open Godot. Import the project.godot file and open the "Color and Particles" project.

You should see a very basic brick-breaker game with a HUD that will control certain effects: adding color to the blocks, the paddle, and the ball; and adding particle effects to the blocks, the paddle, and the walls.

The signals have all been connected, and the code should basicallly be in place. Your assignment is to edit the following scripts, adding functionality to the update_color and emit_particle methods:

 * /Background/Background.gd
 * /Ball/Ball.gd
 * /Brick/Brick.gd
 * /Paddle/Paddle.gd
 * /Walls/Walls.gd

All color references correspond to those defined in the [Open Color scheme](https://yeun.github.io/open-color/). In GDScript, to change the color, use
```
		$Color.color = Color8(R,G,B)
```
and to change back to white, use:
```
		$Color.color = Color(1,1,1,1)
```

The colors should behave as follows:

For the bricks (fill in the list on line 14 of Brick/Brick.gd):
 * Row 0 is RED 8
 * Row 1 is Orange 6
 * Row 2 is Yellow 3
 * Row 3 is Lime 5
 * Row 4 is Blue 6
 * Row 5 is Violet 5
 * Row 6 is Grape 6

For the paddle (line 11 in Paddle/Paddle.gd):
 * Gray 5

For the ball (line 7 in Ball/Ball.gd):
 * Cyan 5

For the background (line 5 in Background/Background.gd), colors should be a list of colors as follows:
 * Black
 * Gray 9
 * Gray 8
 * Gray 9

The update_color function in Brick/Brick.gd should be the following:
```
func update_color():
	if HUD.color_blocks:
		if row >= 0 and row < colors.size():
			$Color.color = colors[row]
	else:
		$Color.color = Color(1,1,1,1)
```

The update_color function in Background/Background.gd should be the following:
```
func update_color():
	if HUD.color_background:
		color = colors[c]
	else:
		color = Color(0,0,0,1)
```


You will also need to edit the particle emmitters in the Walls, Paddle, and Bricks nodes so that the paddle emits confetti, and the walls and bricks emit bubbles (the assets are in the Assets folder).

In the Ball/Ball.tscn and Brick/Brick.tsch scenes, right-click on the root node and add a Particles2D node. In Game.tscn, add a Particles2D node to /Game/Walls and /Game/Paddle_Container/Paddle. 

Then, in the Inspector Panel, edit the particles emitters:

For the walls:
 * Emitting = off
 * Amount = 8
 * Lifetime = 0.4
 * One Shot = on
 * Fract Delta = on
 * Texture = /Assets/bubble.png
 * Process Material->Material = new ParticlesMaterial
  * Flags->Disable Z = On
  * Direction->Spread = 75
  * Gravity = 98
  * Initial Velocity->Velocity = 200
  * Initial Velocity->Velocity Random = 0.5
  * Linear Accel->Accel = 300
  * Linear Accel->Accel Random = 1
  * Radial Accel->Accel = 100
  * Radial Accel->Accel Random = 1
  * Scale->Scale = 0.25
  * Scale->Scale Random = 0.25
  * Scale->Scale Curve = new CurveTexture (make it ramp to 0)
  * Color->Color Ramp = new GradientTexture (make it ramp to transparent)
  * Hue Variation->Variation = 0.1
  * Hue Variation->Variation Random = 0.5
  * Hue Variation->Variation Curve = new CurveTexture (make it ramp to 0)

 When the ball hits the walls, move the Particles2D position and rotation and set emitting=true:

 In Walls/Walls.gd, the emit_particle function should be the following:
 ```
func emit_particle(pos):
	if HUD.particle_walls:
		$Particles2D.emitting = true
		$Particles2D.global_position = pos
		$Particles2D.look_at(get_viewport_rect().size/2)
 ```

 For the paddle:
 * Emitting = off
 * Amount = 6
 * Lifetime = 0.4
 * One Shot = on
 * Texture = /Assets/confetti.png
 * Process Material->Material = new ParticlesMaterial
  * Flags->Disable Z->On
  * Direction->Spread = 60
  * Gravity->Gravity = 98
  * Initial Velocity->Velocity = 450
  * Initial Velocity->Velocity Rand = 0.75
  * Angular Velocity->Velocity = 100
  * Angular Velocity->Velocity Rand = 1
  * Angle->Angle Random = 0.5
  * Angle->Angle Curve = new CurveTexture (make it ramp to 0)
  * Scale->Scale = 0.5
  * Scale->Scale Random = 0.5
  * Scale->Scale Curve = new CurveTexture (make it ramp to 0)
  * Color->Color Ramp = new GradientTexture (make it ramp to transparent)
  * Hue Variation->Variation = 0.7
  * Hue Variation->Variation Random = 0.25
 
 When the ball hits the paddle, move the Particles2D position and rotation and set emitting=true:

 In Paddle/Paddle.gd, the emit_particle function should be the following:
 ```
 func emit_particle(pos):
	if HUD.particle_paddle:
		get_parent().find_node("Particles2D").global_position = pos
		get_parent().find_node("Particles2D").emitting = true
		get_parent().find_node("Particles2D").look_at(pos)
 ```

 For the brick (in /Bricks/Bricks.tscn):
 * Emitting = off
 * Amount = 5
 * Lifetime = 0.4
 * One Shot = On
 * Texture = /Assets/Smoke0.png
 * Process Material->Material = new ParticlesMaterial
  * Flags->Disable Z->On
  * Direction->Spread = 180
  * Initial Velocity->Velocity = 200
  * Initial Velocity->Velocity Rand = 0.5
  * Angular Velocity->Velocity = 50
  * Angular Velocity->Velocity Rand = 1
  * Scale->Scale = 0
  * Scale->Scale Random = 0.2
  * Scale->Scale Curve = new CurveTexture (make it ramp to 0)
  * Color->Color Ramp = new GradientTexture (make it ramp to transparent)
  * Hue Variation->Variation Curve =  new CurveTexture (make it ramp to 0)
 When the ball hits the block, move the Particles2D position and rotation and set emitting=true
In Brick/Brick.gd, the emit_particle function should be the following:
```
func emit_particle(pos):
	if HUD.particle_blocks:
		$Particles2D.texture = textures[randi() % textures.size()]
		$Particles2D.emitting = true
		$Particles2D.global_position = pos

```

 For the ball (in /Bricks/Bricks.tscn):
 * Amount = 5
 * Lifetime = 0.5
 * Frac Delta = On
 * Texture = /Assets/bubble.png
 * Process Material->Material = new ParticlesMaterial
  * Emission Shape->Shape = Sphere
  * Direction->Spread = 180
  * Initial Velocity->Velocity = 300
  * Initial Velocity->Velocity Rand = 0.2
  * Angular Velocity->Velocity = 200
  * Angular Velocity->Velocity Rand = 0.2
  * Orbit Velocity->Velocity = 3
  * Orbit Velocity->Velocity Rand = 0.2
  * Linear Accel->Accel = 200
  * Linear Accel->Accel Rand = 0.5
  * Angular Velocity->Velocity Rand = 0.2
  * Scale->Scale = 0.3
  * Scale->Scale Curve = new CurveTexture (make it ramp to 0)
  * Color->Color Ramp = new GradientTexture (make it ramp to 0)
  * Hue Variation->Variation Curve =  new CurveTexture (make it ramp to 0)
 * Node2D->Position = (7,7)
Append the following to the update_color function, line 39:
```
    if HUD.particle_ball:
        $Particles2D.emitting = true
    else:
        $Particles2D.emitting = false
```


Test the project. You should be able to turn on and off the effects using the Menu (press Esc to activate).

Quit Godot. In GitHub desktop, add a summary message, commit your changes and push them back to GitHub. If you return to and refresh your GitHub repository page, you should now see your updated files with the time when they were changed.

Now edit the README.md file. When you have finished editing, commit your changes, and then turn in the URL of the main repository page (https://github.com/[username]/Exercise-03a-Colors-and-Particles) on Canvas.

The final state of the file should be as follows (replacing my information with yours):
```
# Exercise-03a-Colors-and-Particles
Exercise for MSCH-C220, 17 February 2021

The first steps of an exploration of the "Juice it or Lose it" GDC 2012 presentation in Godot.

## Implementation
Built using Godot 3.2.3

## References
[Juice it or Lose it](https://www.youtube.com/watch?v=Fy0aCDmgnxg)

## Future Development
Tweening, screen shake, music, and sound effects

## Created by 
Jason Francis

```
