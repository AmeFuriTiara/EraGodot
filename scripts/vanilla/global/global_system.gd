extends Node

const WINDOW_MIN_SIZE:Vector2i = Vector2i(800,800) 

var system_default_lang:String = "zh"
var system_lang_zone:String = "zh"

func _ready() -> void:
	get_window().min_size = WINDOW_MIN_SIZE
