class_name GameRoot extends Node


@export var dummy: EntityNode

@export var thief: EntityNode



func _ready() -> void:

	dummy._initialize()

	dummy._activate()

	thief._initialize()

	thief._activate()
