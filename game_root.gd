class_name GameRoot extends Node


@export var dummy: EntityNode

@export var thief: EntityNode

@export var effect: Effect

var effect_data: EffectData



func _ready() -> void:

	dummy._initialize()

	dummy._activate()

	thief._initialize()

	thief._activate()




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("shit_key"):

		if !effect_data:

			effect_data = Game.player.add_effect(effect)

		else:

			Game.player.remove_effect(effect_data)

			effect_data = null