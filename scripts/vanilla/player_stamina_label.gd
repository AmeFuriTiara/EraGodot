extends Label

@onready var parent_node = self.get_parent()

func _ready() -> void:
	GlobalSignal.connect("_init_load_done",Callable(self,"native_update_data"))
	GlobalSignal.connect("_update_stage",Callable(self,"native_update_data"))

func native_update_data():
	var now_stamina = GlobalVar.module_temp_data["character"]["player"]["detail"]["stamina"]
	var max_stamina = GlobalVar.module_temp_data["character"]["player"]["detail"]["max_stamina"]
	self.text = str(int(now_stamina)) + "/" + str(int(max_stamina))
	parent_node.get_parent().get_node("Stamina").text = GlobalVar.module_temp_data["variable"]["normal"]["status"]["stamina"][GlobalSys.system_lang_zone]
	parent_node.max_value = max_stamina
	parent_node.value = now_stamina
