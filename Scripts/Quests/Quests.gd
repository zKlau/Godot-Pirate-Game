extends Node

var quests : Array[Quest_Data]
var active_quest : Quest_Data

func set_active_auto():
	if !active_quest:
		active_quest = quests[0]
	
func add_quest(qu):
	quests.append(qu)
	set_active_auto()
