extends RigidBody3D
func _ready():
	pass
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		apply_central_force(Vector3(10,10,10))
		pass
		
