extends AnimationPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var animations

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_animations(anims):
	animations = anims
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func play_anim(anim_name, flip_h):
	for k in animations:
		if k != anim_name:
			animations[k].visible = false
	
	var anim = animations[anim_name]
	anim.visible = true
	anim.flip_h = flip_h
	self.play(anim_name)