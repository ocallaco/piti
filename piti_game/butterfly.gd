extends Area2D

signal hit
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("bf_flap")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_butterfly_area_entered(area):
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free()