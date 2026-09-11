class_name Disposition extends RefCounted



signal expired



var target_entity: EntityNode



var fear: DispositionAttribute

var affection: DispositionAttribute

var respect: DispositionAttribute




var expiration_timer:= 0.0

var expiration_timer_active:= false






func initialize(_target_entity: EntityNode) -> void:

	target_entity = _target_entity

	fear = DispositionAttribute.new()

	fear.attribute = BehaviorAttribute.Attribute.FEAR

	affection = DispositionAttribute.new()

	affection.attribute = BehaviorAttribute.Attribute.AFFECTION

	respect = DispositionAttribute.new()

	respect.attribute = BehaviorAttribute.Attribute.RESPECT
	




func start_expiration_timer() -> void:

	expiration_timer = 8.0

	expiration_timer_active = true



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