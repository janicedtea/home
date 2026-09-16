extends Node2D
@onready var music: AudioStreamPlayer2D = $music
@onready var score_1_label: Label = $CanvasLayer/score1/score1label
@onready var score_2_label: Label = $CanvasLayer/score2/score2label

var score1: int = 0
var score2: int = 0

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
	var coins = $level.get_node_or_null("coins")
	if coins:
		for coin in coins.get_children():
			coin.collected1.connect(increase_score1)
			coin.collected2.connect(increase_score2)
#signals
func _on_player_died(body):
	body.die()
	print("player died :(")


func increase_score1() -> void:
	score1 += 1
	score_1_label.text = "Player 1 Score: " + str(score1)
func increase_score2() -> void:
	score2 += 1
	score_2_label.text = "Player 2 Score: " + str(score2)
