extends Path2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var follow = get_node("follow")

var life_s = .5
var timer

func _init():
	self.curve.clear_points()
	self.curve.add_point(Vector2(0,0))
	self.curve.add_point(Vector2(500,500))
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_autostart(false)
	timer.connect("timeout", self, "_on_timer_timeout")
	add_child(timer)
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	timer.start(life_s)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	follow.set_unit_offset(follow.get_unit_offset() + (delta * (1 / life_s)))



func _on_timer_timeout():
	print("ALL DONE")
	set_process(false)
	