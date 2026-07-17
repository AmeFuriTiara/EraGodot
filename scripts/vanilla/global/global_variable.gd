extends Node

var now_module_name:String
var module_native_path:String
var module_temp_data:Dictionary = {
	"character":{},
	"event":{},
	"variable":{},
	"personality":{},
	"colortable":{}
}
var module_cfg:Dictionary
var module_relate_path:Dictionary

var character_json_path:Dictionary = {}
var event_json_path:Dictionary = {}

var playing_data:Dictionary = {}

var character_on_stage:Array = ["asari","player"]
var character_ping:String = "asari"
