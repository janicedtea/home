extends Node2D
@onready var music: AudioStreamPlayer2D = $music


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music.play()
	_setup_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _setup_level() -> void:
	var enemies = $level.get_node_or_null("enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)

#signals
func _on_player_died(body):
	print("player died :(")
