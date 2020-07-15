extends Area2D

signal frog_eaten

func _ready():
	pass 


func _on_frog_area_entered(area):
	if area.name == "head":
		queue_free()
		emit_signal("frog_eaten")
