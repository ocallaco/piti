extends Node2D

export (PackedScene) var Butterfly
export (PackedScene) var Heart

var screen_size
var borderh = 100
var borderv = 100
var heartcount = 0
var maxhearts = 50
var hearts 
var heart_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func start_hearts(pos):
	heart_pos = pos
	$heart_timer.start()
	
func create_heart():
	var h = Heart.instance()
	add_child(h)
	var angle = rand_range(-PI, PI)
	var mag = randi() % 1000
	var dest = heart_pos + (mag * Vector2(cos(angle), -sin(angle)))
	h.start(0.5, heart_pos, dest)
	
func _on_butterfly_touched():
	$bf_timer.start()
	$piti.dance()
	$piti.stop()
	start_hearts($piti.position)

func _on_bf_timer_timeout():
	var bf = Butterfly.instance()
	bf.connect("hit", self, "_on_butterfly_touched")
	add_child(bf)
	bf.position.x = (randi() % (int(screen_size.x) - (2 * borderh)) + borderh)
	bf.position.y = (randi() % (int(screen_size.y) - (2 * borderv)) + borderv)
	$bf_timer.stop()
	

func _on_heart_timer_timeout():
	if heartcount < maxhearts:
		create_heart()
		heartcount = heartcount + 1
	else:
		$heart_timer.stop()
		heartcount = 0
