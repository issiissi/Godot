
extends Node3D
var rotation_speed := 1.5 

func _ready():
	print("Node ist bereit.")

func _process(delta):
	# Links (ui_left): Rotation um Y-Achse positiv
	if Input.is_action_pressed("ui_left"):
		rotation.y += rotation_speed * delta
		print("Links gedrückt")

	# Rechts (ui_right): Rotation um Y-Achse negativ
	if Input.is_action_pressed("ui_right"):
		rotation.y -= rotation_speed * delta
		print("Rechts gedrückt")

	# Oben (ui_up): Rotation um X-Achse positiv
	if Input.is_action_pressed("ui_up"):
		rotation.x += rotation_speed * delta
		print("Oben gedrückt")

	# Unten (ui_down): Rotation um X-Achse negativ
	if Input.is_action_pressed("ui_down"):
		rotation.x -= rotation_speed * delta
		print("Unten gedrückt")
		
