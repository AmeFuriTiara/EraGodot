extends Label

@onready var parent_node = self.get_parent()

func _ready() -> void:
	GlobalSignal.connect("_init_load_done",Callable(self,"native_update_data"))
	GlobalSignal.connect("_update_stage",Callable(self,"native_update_data"))

func native_update_data():
	var now_energy = GlobalVar.module_temp_data["character"]["player"]["detail"]["energy"]
	var max_energy = GlobalVar.module_temp_data["character"]["player"]["detail"]["max_energy"]
	self.text = str(int(now_energy)) + "/" + str(int(max_energy))
	parent_node.get_parent().get_node("Energy").text = GlobalVar.module_temp_data["variable"]["normal"]["status"]["energy"][GlobalSys.system_lang_zone]
	parent_node.max_value = max_energy
	parent_node.value = now_energy
