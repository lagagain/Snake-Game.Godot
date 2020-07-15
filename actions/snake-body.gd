extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dir_arr = []
var dir_arr_time = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_body_area_entered(area):
	if area.name == "head":
		get_tree().reload_current_scene()
