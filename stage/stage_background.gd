extends TextureRect

func _ready() -> void:
	GlobalSignal.connect("_init_load_done",Callable(self,"native_update_data"))
	GlobalSignal.connect("_update_stage",Callable(self,"native_update_data"))

func native_update_data():
	var stage = ["stage"]
	for i in GlobalVar.in_game_data["now_location"]:
		stage.append(i)
	var sprite_path = GlobalFunc._get_sprite_path(stage)
	var load_result = Image.load_from_file(sprite_path)
	var t_texture = ImageTexture.create_from_image(load_result)
	self.texture = t_texture
