extends Node3D

@onready var sun: DirectionalLight3D = $Sun
@onready var world: Environment = $WorldEnvironment.environment
@onready var sky_material := world.sky.sky_material as ShaderMaterial

func _ready() -> void:
	world.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR

func _process(_delta: float) -> void:
	var progress := EventManager.get_day_progress()
	var orbit := progress * TAU + deg_to_rad(8.0)
	var sun_dir := Vector3(cos(orbit), sin(orbit), 0.0)
	sun_dir = sun_dir.rotated(Vector3.RIGHT, deg_to_rad(40.0))
	sun_dir = sun_dir.rotated(Vector3.UP, deg_to_rad(90.0))
	sun.look_at(sun.global_position - sun_dir, Vector3.UP)

	var moon_dir := (-sun_dir).rotated(Vector3.UP, deg_to_rad(35.0))
	var moon_basis := Basis.looking_at(-moon_dir, Vector3.UP)

	sky_material.set_shader_parameter("sun_dir", sun_dir)
	sky_material.set_shader_parameter("moon_dir", moon_dir)
	sky_material.set_shader_parameter("moon_world_to_object", moon_basis.inverse())

	var daylight := smoothstep(-0.16, 0.22, sun_dir.y)
	sun.light_energy = maxf(sun_dir.y, 0.0) * 1.5
	sun.light_color = Color("#FFAA70").lerp(Color("#FFF3DF"), daylight)
	world.ambient_light_color = Color("#8599C8").lerp(Color("#FFF0D5"), daylight)
	world.ambient_light_energy = lerpf(0.2, 0.65, daylight)
