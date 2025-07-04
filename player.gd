extends Area2D

@export var speed = 700  # How fast the player will move (pixels/sec).

var screen_size  # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size
	var sprite := get_node("Sprite2D")
	var paddle_height = sprite.texture.get_size().y
	var gap = 20  # pixels above the bottom of the screen
	
	# Center the paddle horizontally for a clear start
	position.x = screen_size.x / 2
	position.y = screen_size.y - paddle_height / 2 - gap
	

func _process(delta):
	var direction := 0.0
	if Input.is_action_pressed("move_left"):
		direction -= 1
	if Input.is_action_pressed("move_right"):
		direction += 1
	
	position.x += direction * speed * delta
	
	var sprite = get_node("Sprite2D")
	var sprite_scale = sprite.scale.x  # in case your sprite is scaled
	var paddle_width = sprite.texture.get_size().x * sprite_scale
	var half_width = paddle_width / 2
	
	position.x = clamp(position.x, half_width, screen_size.x - half_width)
	
