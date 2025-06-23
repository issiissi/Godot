extends MeshInstance3D

func _ready():
	var mesh = ArrayMesh.new()
	self.mesh = mesh

	var verts = PackedVector3Array()
	verts.append(Vector3(0, 0, 0))
	verts.append(Vector3(1, 0, 0))
	verts.append(Vector3(0, 1, 0))

	var surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)
	surface_array[Mesh.ARRAY_VERTEX] = verts

	# Einfaches Dreieck ohne Index-Array (Godot nutzt dann 0,1,2)
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array)

func _process(delta):
	pass
