class_name Disposition extends RefCounted



signal expired

signal fear_updated

signal affection_updated

signal respect_updated



var target_entity: EntityNode



var fear:= 0.0

var affection:= 0.0

var respect:= 0.0




var expiration_timer:= 0.0

var expiration_timer_active:= false





func start_expiration_timer() -> void:

	expiration_timer = 15.0

	expiration_timer_active = true



func stop_expiration_timer() -> void:

	expiration_timer_active = false




func update_fear(amount: float) -> void:

	fear += amount

	fear_updated.emit()



func update_affection(amount: float) -> void:

	affection += amount

	affection_updated.emit()



func update_respect(amount: float) -> void:

	respect += amount

	respect_updated.emit()





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