extends Node2D
@onready var music: AudioStreamPlayer2D = $music
@onready var score_1_label: Label = $CanvasLayer/score1/score1label
@onready var score_2_label: Label = $CanvasLayer/score2/score2label

var level: int = 1
var player1_dead = false
var player2_dead = false
var score1: int = 0
var score2: int = 0
var current_level_root: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music.play()
	current_level_root = get_node("level")
	_load_level(level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

#level management
func _load_level(level_number: int) -> void:
	if current_level_root:
		current_level_root.queue_free()
	#change level
	var level_path = "res://level%s.tscn" % level_number
	current_level_root = load(level_path).instantiate()
	add_child(current_level_root)
	current_level_root.name = "level"
	_setup_level(current_level_root)
func _setup_level(level: Node) -> void:
	var exit = level.get_node("flag/exit")
	if exit:
		exit.body_entered.connect(_on_exit_body_entered)
	var enemies = level.get_node_or_null("enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)
	var coins = level.get_node_or_null("coins")
	if coins:
		for coin in coins.get_children():
			coin.collected1.connect(increase_score1)
			coin.collected2.connect(increase_score2)
#signals
func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "player1" or body.name == "player2":
		level += 1
		print(level)
		body.can_move = false
		call_deferred("_load_level", level)

func _on_player_died(body):
	body.die()
	if body.name == "player1":
		player1_dead = true
	if body.name == "player2":
		player2_dead = true


func increase_score1() -> void:
	score1 += 1
	score_1_label.text = "Player 1 Score: " + str(score1)
func increase_score2() -> void:
	score2 += 1
	score_2_label.text = "Player 2 Score: " + str(score2)
