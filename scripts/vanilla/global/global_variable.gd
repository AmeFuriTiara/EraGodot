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

var in_game_data:Dictionary = {
	"player_ping":"asari",
	"season":1,
	"week_count":1,
	"day_count":1,
	"time_h":11,
	"time_m":1,
	"time_mark":"",
	"weather":"sunny",
	"temperature":17,
	"now_location":["school","auditorium_outside"],
	"character_on_stage":["player","asari","saki"],
	"select_one":"asari"
}
