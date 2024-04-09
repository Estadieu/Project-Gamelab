extends Node

const ITEM_LIST = [
	"icespear" ,
	"javelin"  ,
	"snowball" ,
	"armor"    ,
	"speed"    ,
	"tome"     ,
	"scroll"   ,
	"ring"     ,
]

const TYPE_LIST = [
	"weapon",
	"gun",
	"upgrade"
]

var items = {}
var types = {}

func _ready():
	for item_name in ITEM_LIST:
		items[item_name] = get_node('items/' + item_name)
		
	for type_name in TYPE_LIST:
		types[type_name] = get_node('types/' + type_name)
	
