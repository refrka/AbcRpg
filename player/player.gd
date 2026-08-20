class_name Player extends CharacterNode






func _ready() -> void:

	_initialize()

	_activate.call_deferred()







func _activate() -> bool:

	if !super(): return false

	Events.fire(PlayerActivatedEvent)

	return true




func _deactivate() -> bool:

	if !super(): return false

	Events.fire(PlayerDeactivatedEvent)

	return true