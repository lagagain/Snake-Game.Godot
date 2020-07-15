extends Node2D


onready var frog = preload("res://scenes/frog.tscn")

func _ready():
	add_frog()
	
func add_frog():
	randomize()
	var inst = frog.instance()
	inst.position = Vector2(randi()%1144+56, randi()%834+56)
	inst.connect("frog_eaten", self, "spaw_next_frog")
	add_child(inst)

func spaw_next_frog():
	add_frog()
	get_node("snake").add_body()


func _on_wall_area_entered(area):
	if area.name == "head":
		get_tree().reload_current_scene()
