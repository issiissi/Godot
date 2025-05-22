extends Node3D
#Called when the node enters the scene tree for the first time.
func _ready():
	#code zum initialisieren.
	pass # Replace with function body.


#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		rotation.y += 0.01
		print("links gedrückt")
	#wird aufgerufen wenn ein bild gerendert wird 
	
