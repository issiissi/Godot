extends MeshInstance3D

func _ready() -> void:
	var radius = 2.0
	var segments = 40
	_create_circle(radius, segments)

func _create_circle(r: float, s: int) -> void:
	var verts = PackedVector3Array()

	# Punkte auf dem Kreis berechnen
	for i in range(s):
		var angle = i * (2.0 * PI / s)
		var x = r * cos(angle)
		var z = r * sin(angle)
		verts.append(Vector3(x, 0, z))

	# Kreis schließen (letzten Punkt noch mal anhängen)
	verts.append(verts[0])

	# Array für das Mesh vorbereiten
	var surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)

	# ✅ HIER ist die KORREKTE ERSETZUNG der fehlerhaften Zeile:
	surface_array[Mesh.ARRAY_VERTEX] = verts

	# Mesh erstellen
	var my_mesh = ArrayMesh.new()
	my_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINE_STRIP, surface_array)

	# Material hinzufügen, damit die Linien sichtbar sind
	var mat = StandardMaterial3D.new()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.albedo_color = Color.RED
	my_mesh.surface_set_material(0, mat)

	# Mesh anwenden
	mesh = my_mesh

func _process(delta: float) -> void:
	pass
