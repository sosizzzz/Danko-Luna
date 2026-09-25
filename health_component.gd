extends Node
class_name HealthComponent

@export var maxHealth : int = 3
var health : int = 0
signal died

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	health = maxHealth
	
	pass # Replace with function body.
	

func take_damage(damage):
	health -= damage
	
	if health <= 0:
		died.emit()

	
