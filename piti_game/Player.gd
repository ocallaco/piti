extends Area2D

export var speed = 600  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
var destination
var dances = 0

func _init():
	pass

func _ready():
	screen_size = get_viewport_rect().size
	$AnimationPlayer.set_animations({
		"walk_h":  $piti_walk,
		"walk_up": $piti_up,
		"walk_dn": $piti_down,
		"dance": $piti_dance,
	})
	position = screen_size / 2
	destination = position
	$piti_walk.set_visible(true)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			destination = event.position
func stop():
	destination = position
func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	var step = Vector2()
	
	if dances == 0 && position != destination:
		velocity = destination - position
		velocity = velocity.normalized() * speed
		step = velocity * delta
		
	if step.length() > (destination - position).length():
		step = destination - position
	
	if velocity.length() > 0:
		var mvmt_angle = velocity.angle()
		if mvmt_angle >= 0:
			if mvmt_angle <= PI/4:
				$AnimationPlayer.play_anim("walk_h", false)
			elif mvmt_angle > PI/4 && mvmt_angle <= (3 * PI) / 4:
				$AnimationPlayer.play_anim("walk_dn", false)
			else:
				$AnimationPlayer.play_anim("walk_h", true)
		else:
			if mvmt_angle >= -PI/4:
				$AnimationPlayer.play_anim("walk_h", false)
			elif mvmt_angle >= (-3 * PI) / 4:
				$AnimationPlayer.play_anim("walk_up", false)
			else:
				$AnimationPlayer.play_anim("walk_h", true)
	else:
		if dances > 0:
			$AnimationPlayer.play_anim("dance", dances % 2 == 0)
		else:
			$AnimationPlayer.stop()
	
	position += step
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func dance():
	dances = 4
	$dance_timer.start()
	

func _on_dance_timer_timeout():
	dances = dances - 1
	if dances == 0:
		$AnimationPlayer.play_anim("walk_h", false)
		$dance_timer.stop()
