extends Node2D

const DEFAULT_CELL_ID: int = 0

onready var water_tilemap: TileMap = get_node("Water")
onready var grass_tilemap: TileMap = get_node("Grass")
onready var animated_water_tilemap: TileMap = get_node("AnimatedWater")

var simplex_noise : OpenSimplexNoise = OpenSimplexNoise.new()

export(int) var map_width = 40
export(int) var map_height = 40

export(String) var world_seed = "Dev Bandeira"

export(int) var noise_octaves = 5
export(int) var noise_period = 5
export(float) var noise_persistence = 0.1
export(float) var noise_lacunarity = 0.1
export(float) var noise_threshold = 0.1

func _ready() -> void:
	randomize()
	
	global_data.load_data()
	var file: File = File.new()
	if file.file_exists(global_data.save_path):
		printerr("Mapa Carregado...")
		serialize_data()
		return
		
	pre_noise_configuration()
	generate()
	
	
func pre_noise_configuration() -> void:
	simplex_noise.seed = world_seed.hash()
	simplex_noise.octaves = noise_octaves
	simplex_noise.period = noise_period
	simplex_noise.persistence = noise_persistence
	simplex_noise.lacunarity = noise_lacunarity
	
	
func generate() -> void:
	for x in range(-map_width/2, map_width/2):
		for y in range(-map_height/2, map_height/2):
			if simplex_noise.get_noise_2d(x, y) < noise_threshold:
				set_autotile(x, y)
				continue
				
			set_water_tile(x, y)
			
	generate_animated_water_tiles()
	
	
func set_autotile(x: int, y: int) -> void:
	grass_tilemap.set_cell(
		x, y, DEFAULT_CELL_ID
	)
	
	global_data.data_dictionary.grass_dict[Vector2(x, y)] = Vector2(x, y)
	grass_tilemap.update_bitmask_area(Vector2(x, y))
	
	
func set_water_tile(x: int, y: int) -> void:
	water_tilemap.set_cell(x, y, DEFAULT_CELL_ID)
	global_data.data_dictionary.water_dict[Vector2(x, y)] = Vector2(x, y)
	
	
func generate_animated_water_tiles() -> void:
	for cell in grass_tilemap.get_used_cells():
		animated_water_tilemap.set_cellv(cell, DEFAULT_CELL_ID)
		global_data.data_dictionary.animated_water_dict[cell] = cell
		
	global_data.save_data()
	
	
func serialize_data() -> void:
	for cell in global_data.data_dictionary.grass_dict:
		grass_tilemap.set_cellv(cell, DEFAULT_CELL_ID)
		grass_tilemap.update_bitmask_area(cell)
		
	for cell in global_data.data_dictionary.water_dict:
		water_tilemap.set_cellv(cell, DEFAULT_CELL_ID)
		
	for cell in global_data.data_dictionary.animated_water_dict:
		animated_water_tilemap.set_cellv(cell, DEFAULT_CELL_ID)
		
		
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		var _reload: bool = get_tree().reload_current_scene()
