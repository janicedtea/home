extends Area2D
@onready var collectedsound: AudioStreamPlayer2D = $collectedsound
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

signal collected1
signal collected2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player1":
		collected1.emit()
		call_deferred("_disable_collision")
		clear_coin()
	elif body.name == "player2":
		collected2.emit()
		call_deferred("_disable_collision")
		clear_coin()

func _disable_collision() -> void:
	collision_shape_2d.disabled = true
func clear_coin() -> void:
	queue_free()
