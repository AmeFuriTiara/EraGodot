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
	"temp":{
		"select_one_name":"",
	},
	"player_ping":"asari",
	"season":1,
	"day_count":1,
	"youbi":1,
	"time_h":10,
	"time_m":0,
	"weather":"sunny",
	"temperature":17,
	"now_location":["school","auditorium_inside"],
	"location_dirty":[],
	"description":"'空气中弥漫着一股花香'",
	"character_on_stage":["player","asari"]
}
