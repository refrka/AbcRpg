class_name GameRoot extends Node


@export var world_root: Node2D

@export var thief: CharacterNode

var navigation_component: NavigationComponent



func _ready() -> void:

	for child in world_root.get_children():

		if child is EntityNode:

			child.initialize()

			child.activate()

	navigation_component = thief.get_component(NavigationComponent)

	print(navigation_component)







func _input(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:

		navigation_component.set_target_position(world_root.get_global_mouse_position())