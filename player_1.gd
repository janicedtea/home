extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jumpsound: AudioStreamPlayer2D = $jumpsound
@onready var deathsound: AudioStreamPlayer2D = $deathsound


const SPEED = 300.0
const JUMP_VELOCITY = -800.0
var alive = true
var can_move = true
var start_position: Vector2


func _ready() -> void:
	start_position = position

func _physics_process(delta: float) -> void:
	if position.y >= 735:
		respawn()
	if !alive:
		return
	animated_sprite_2d.animation = "idle_walk"

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jumping"
	
	if can_move:
		# Handle jump.
		if Input.is_action_just_pressed("jump1") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			jumpsound.play()

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("left1", "right1")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
		if direction == 1:
			animated_sprite_2d.flip_h = false
		elif direction == -1:
			animated_sprite_2d.flip_h = true

func die() -> void:
	deathsound.play()
	animated_sprite_2d.animation = "dead"
	alive = false
	await get_tree().create_timer(1.0).timeout
	respawn()
func respawn() -> void:
	position = start_position
	velocity = Vector2.ZERO
	alive = true
	can_move = true
	animated_sprite_2d.animation = "idle_walk"
