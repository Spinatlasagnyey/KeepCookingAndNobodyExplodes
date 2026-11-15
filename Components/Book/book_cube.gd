extends StaticBody3D

@export var rulebook: Rulebook
@onready var closed_model: Node3D = $ClosedBook
@onready var open_model: Node3D = $OpenBook

@onready var left_page: RichTextLabel = make_page($LeftViewport, $LeftPage)
@onready var right_page: RichTextLabel = make_page($RightViewport, $RightPage)
@onready var flip_pivot := get_node_or_null("FlipPivot") as Node3D

var pages: Array[String] = []
var spread := 0
var flipping := false


func _ready() -> void:
	closed_model.show()
	open_model.hide()
	$LeftPage.hide()
	$RightPage.hide()
	
	if flip_pivot:
		flip_pivot.hide()

	pages = [
		"[b]On this site you find the[/b]\nMushroom Rules",
		"[b]On this site you find the[/b]\nCooking and preparation"
	]

	for rule in rulebook.rules:
		if rule != null:
			pages.append(rule.get_description())

	show_spread(0)

func make_page(viewport: SubViewport, mesh: MeshInstance3D) -> RichTextLabel:
	viewport.size = Vector2i(480, 760)
	viewport.disable_3d = true
	viewport.transparent_bg = true

	var label := RichTextLabel.new()
	label.position = Vector2(32, 40)
	label.size = Vector2(416, 680)
	label.bbcode_enabled = true
	label.scroll_active = false
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.add_theme_color_override("default_color", Color("#332518"))
	label.add_theme_font_size_override("normal_font_size", 36)
	label.add_theme_font_size_override("bold_font_size", 44)
	viewport.add_child(label)

	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.albedo_texture = viewport.get_texture()
	mesh.material_override = material

	return label

func _input_event(
	_camera: Camera3D,
	event: InputEvent,
	_position: Vector3,
	_normal: Vector3,
	_shape_index: int
) -> void:
	if open_model.visible:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		closed_model.hide()
		open_model.show()
		$LeftPage.show()
		$RightPage.show()
		
func _input(event: InputEvent) -> void:
	var camera := get_viewport().get_camera_3d()
	
	if not open_model.visible:
		return
		
	if camera == null or not camera.is_position_in_frustum(global_position):
		return

	if event.is_action_pressed("ui_left"):
		get_viewport().set_input_as_handled()
		turn_to(spread - 1)
	elif event.is_action_pressed("ui_right"):
		get_viewport().set_input_as_handled()
		turn_to(spread + 1)


func show_spread(index: int) -> void:
	spread = index
	var left_index := spread * 2
	var right_index := left_index + 1

	left_page.text = pages[left_index]
	right_page.text = pages[right_index] if right_index < pages.size() else ""


func turn_to(index: int) -> void:
	if flipping or index < 0 or index * 2 >= pages.size():
		return

	if flip_pivot == null:
		show_spread(index)
		return

	flipping = true
	var forward := index > spread
	flip_pivot.rotation_degrees.z = 0.0 if forward else 180.0
	flip_pivot.show()

	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(flip_pivot, "rotation_degrees:z", 90.0, 0.2).set_ease(Tween.EASE_IN)
	tween.tween_callback(show_spread.bind(index))

	var end_angle := 180.0 if forward else 0.0
	tween.tween_property(flip_pivot, "rotation_degrees:z", end_angle, 0.2).set_ease(Tween.EASE_OUT)
	await tween.finished

	flip_pivot.hide()
	flipping = false
