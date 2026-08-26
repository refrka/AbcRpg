class_name Disposition extends RefCounted



signal expired




var target_entity: EntityNode



var fear:= 0.0

var affection:= 0.0

var respect:= 0.0




var expiration_timer:= 0.0

var expiration_timer_active:= false





func start_expiration_timer() -> void:

	expiration_timer = 15.0



func stop_expiration_timer() -> void:

	expiration_timer_active = false





func tick(delta: float) -> void:

	if expiration_timer_active:

		expiration_timer -= delta

		if expiration_timer <= 0.0:

			_expire()





func _expire() -> void:

	expired.emit()





static func create_new(entity_node: EntityNode) -> Disposition:

	var disposition = Disposition.new()

	disposition.target_entity = entity_node

	return disposition