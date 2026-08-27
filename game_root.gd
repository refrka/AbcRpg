class_name GameRoot extends Node


@export var world_root: Node2D

@export var thief: CharacterNode

@export var hitbox: Hitbox

@export var attack_entry: AttackEntry



var navigation_component: NavigationComponent

var movement_component: MovementComponent





func _ready() -> void:

	for child in world_root.get_children():

		if child is EntityNode:

			child.initialize()

			child.activate()

	navigation_component = thief.get_component(NavigationComponent)

	movement_component = thief.get_component(MovementComponent)

	hitbox.initialize()

	hitbox.activate()

	hitbox.hit_detected.connect(_on_hit_detected)






func _on_hit_detected(entity_node: EntityNode) -> void:

	var damage_package = DamagePackage.new()

	damage_package.add_damage_entry(DamageEntry.from_attack_entry(attack_entry))

	entity_node.receive_damage_package(damage_package)







func _input(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:

		var mouse_pos = world_root.get_global_mouse_position()

		navigation_component.set_target_position(mouse_pos)