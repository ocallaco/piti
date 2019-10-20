extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var life
var opacity = 1
var timer 
var destination

# Called when the node enters the scene tree for the first time.
func _ready():
#	timer = Timer.new()
#	timer.set_one_shot(true)
#	timer.connect("timeout", self, "_on_timeout")
#	timer.start(2)
#	self.add_child(timer)
	set_process(false)
	
func start(set_life, pos, dest):
	life = set_life
	position = pos
	destination = dest
	set_process(true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	opacity = opacity - (delta / life)
	if opacity < 0:
		queue_free()
	self.modulate.a = opacity
	
	var step = (destination - position) * (delta / life)
	position = position + step