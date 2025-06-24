extends MeshInstance3D

func _ready() -> void:
	var radius = 2.0
	var height = 4.0
	var segments = 40
	_create_cylinder(radius, height, segments)

func _create_cylinder(radius: float, height: float, segments: int) -> void:
	var verts = PackedVector3Array()
	var indices = PackedInt32Array()

	
	for i in range(segments):
		var angle = i * (2.0 * PI / segments)
		var x = radius * cos(angle)
		var z = radius * sin(angle)
		verts.append(Vector3(x, 0, z))          # Unten 
		verts.append(Vector3(x, height, z))     # Oben 

	# Mittelpunkte
	var bottom_center_index = verts.size()
	verts.append(Vector3(0, 0, 0))  # Mittelpunkt unten

	var top_center_index = verts.size()
	verts.append(Vector3(0, height, 0))  # Mittelpunkt oben

	# Seitenflächen und Deckel-Dreiecke
	for i in range(segments):
		var i0 = i * 2
		var i1 = ((i + 1) % segments) * 2

		# Seitenfläche (2 Dreiecke)
		indices.append(i0)
		indices.append(i1)
		indices.append(i1 + 1)

		indices.append(i0)
		indices.append(i1 + 1)
		indices.append(i0 + 1)

		# Untere Deckel-Dreiecke 
		indices.append(bottom_center_index)
		indices.append(i0)
		indices.append(i1)

		# Obere Deckel-Dreiecke
		indices.append(top_center_index)
		indices.append(i0 + 1)
		indices.append(i1 + 1)

	# Mesh-Array 
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = verts
	arrays[Mesh.ARRAY_INDEX] = indices

	# Mesh erzeugen
	var mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)

	# Material zuweisen
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color("lightblue")
	mat.metallic = 0.1
	mat.roughness = 0.7
	mesh.surface_set_material(0, mat)

	# Mesh anwenden
	self.mesh = mesh
