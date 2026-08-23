class_name Disposition extends RefCounted



signal expired




var fear:= FearAttribute.new()

var affection:= AffectionAttribute.new()

var respect:= RespectAttribute.new()





var target_entity: EntityNode

var expiration_timer:= 0.0

var timer_active:= false






func start_timer() -> void:

	expiration_timer = 3.0

	timer_active = true





func stop_timer() -> void:

	timer_active = false

	expiration_timer = 0.0






func tick(delta: float) -> void:

	if timer_active and expiration_timer > 0.0:

		expiration_timer -= delta

		if expiration_timer <= 0.0:

			timer_active = false

			expired.emit()








static func create_new(_target_entity: EntityNode) -> Disposition:

	var disposition = Disposition.new()

	disposition.target_entity = _target_entity

	return disposition