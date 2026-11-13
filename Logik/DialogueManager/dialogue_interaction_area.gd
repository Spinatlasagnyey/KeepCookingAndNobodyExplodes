extends Area2D

@export var dialogue: DialogueResource

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().get_first_node_in_group("dialogue_manager").start_dialogue(self, dialogue)
