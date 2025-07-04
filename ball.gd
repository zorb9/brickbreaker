extends Area2D

@export var speed: float = 300.0
var velocity: Vector2 = Vector2(1, -1).normalized()

func _physics_process(delta):
	position += velocity * speed * delta

	# Bounce off screen sides
	if position.x < 0:
		position.x = 0
		velocity.x *= -1
	elif position.x > get_viewport_rect().size.x:
		position.x = get_viewport_rect().size.x
		velocity.x *= -1

	# Bounce off top
	if position.y < 0:
		position.y = 0
		velocity.y *= -1

	# If it falls below screen, emit signal or handle loss
	if position.y > get_viewport_rect().size.y:
		queue_free()  # Or emit_signal("ball_lost") if you're tracking lives


func _on_ball_body_entered(body):
	if body.name == "Paddle":
		velocity.y = -abs(velocity.y)  # bounce up no matter what
		velocity.y *= -1
		body.queue_free()  # destroy the brick
