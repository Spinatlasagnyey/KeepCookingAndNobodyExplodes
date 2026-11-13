class_name DialogueResource
extends Resource 

@export var start_id: int = 0

@export var nodes: Dictionary[int, DialogueNode] = {}

func get_node(id: int) -> DialogueNode:
	return nodes.get(id)

func has_node(id: String) -> bool:
	return nodes.has(id)

##this needs to be able to:
#have opportunity for answers creating new paths for the dialogue
#maybe every answer has a field next_sentence which is just a refence to the id or smth of the sentence that follows the answer
#maybe each one of the sentences has a next snetence identifier too, standard would be the next in line
#the text nees to have tags like <wiggly> which will make the text in it have an effect
#when you reach the end you need an end node that has a callable for what happens in game after the talk, or just empty if nothing happens
