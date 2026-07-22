extends ScrollContainer

@onready var cha_unit = preload("res://stage/character_unit.tscn")
@onready var cha_pool = $CharacterPool

func _ready() -> void:
	GlobalSignal.connect("_init_load_done",Callable(self,"native_update_data"))
	GlobalSignal.connect("_update_stage",Callable(self,"native_update_data"))

func native_update_data():
	var list = GlobalVar.in_game_data["character_on_stage"].duplicate_deep()
	if list.has("player"):
		list.erase("player")
	if list.size() > 0:
		var child = cha_pool.get_children()
		for i in child:
			if list.has(i.s_name):
				list.erase(i.s_name)
			else:
				i.free()
	for i in list:
		if GlobalVar.in_game_data["select_one"] == "":
			GlobalVar.in_game_data["select_one"] = i
		var unit = cha_unit.instantiate()
		unit.s_name = i
		cha_pool.add_child(unit)
		unit.init_self()
