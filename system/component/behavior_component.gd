class_name BehaviorComponent extends Component


signal disposition_generated(disposition: Disposition)



enum EvaluationMode {

	SLOW,

	NORMAL,

	FAST,

	NONE,

}


@export var evaluation_mode: EvaluationMode


var behaviors: Array[Behavior]

var current_behavior: Behavior




var attitude:= 0.0

var temperament:= 0.0


var dispositions: Array[Disposition]




var evaluation_timer:= 0.0

var evaluation_mode_time:= 5.0

var evaluation_cooldown:= 0.0




func initialize(_entity: EntityNode) -> void:

	super(_entity)

	for _behavior in entity.entity_def.behavior_profile.behaviors:

		var behavior = _behavior.duplicate(true)

		behaviors.append(behavior)

		behavior.initialize(entity, self)

		behavior.evaluation_requested.connect(_on_behavior_evaluation_requested.bind(behavior))

	set_evaluation_mode(evaluation_mode)

	





func _evaluate_all(disposition: Disposition = null) -> void:

	print("\nBehavior evaluation begin")

	print("==============================")

	if disposition:

		print("Disposition: %s" % disposition.target_entity.get_display_name())

	else:

		print("(no disposition)")

	print("==============================")

	if evaluation_cooldown > 0.0:

		return

	evaluation_timer = 0.0

	var best_behavior: Behavior = null

	var best_score:= -INF

	for behavior in behaviors:

		var score = behavior.evaluate(disposition)

		print("> %s (%s)" % [behavior.get_display_name(), score])

		if !best_behavior or score > best_score:

			best_behavior = behavior

			best_score = score

	print("==============================")

	print("Chosen behavior: ", best_behavior.get_display_name())

	_change_behavior(best_behavior)
	
	evaluation_timer = evaluation_mode_time





func _change_behavior(new_behavior: Behavior) -> void:

	if new_behavior == current_behavior:

		return

	if current_behavior:

		current_behavior.stop()

	current_behavior = new_behavior

	current_behavior.start()





func receive_damage_package(damage_package: DamagePackage) -> void:

	pass




func get_behavior_profile() -> BehaviorProfile:

	return entity.entity_def.behavior_profile




func get_disposition(entity_node: EntityNode) -> Disposition:

	for disposition in dispositions:

		if disposition.target_entity == entity_node:

			return disposition
		
	return null




func set_evaluation_mode(mode: EvaluationMode) -> void:

	evaluation_mode = mode

	match evaluation_mode:

		EvaluationMode.SLOW: evaluation_mode_time = 5.0

		EvaluationMode.NORMAL: evaluation_mode_time = 1.0

		EvaluationMode.FAST: evaluation_mode_time = 0.2

		EvaluationMode.NONE: evaluation_mode_time = -1.0




func activate() -> void:

	super()

	_evaluate_all()





func _generate_disposition(target_entity: EntityNode) -> Disposition:

	var disposition = Disposition.create_new(target_entity)

	dispositions.append(disposition)

	disposition_generated.emit(disposition)

	_evaluate_all()

	return disposition




func _connect_signals() -> void:

	entity.vision_sensor.entity_entered_sensor.connect(_on_entity_entered_sensor)

	entity.vision_sensor.entity_exited_sensor.connect(_on_entity_exited_sensor)



func _disconnect_signals() -> void:

	entity.vision_sensor.entity_entered_sensor.disconnect(_on_entity_entered_sensor)

	entity.vision_sensor.entity_exited_sensor.disconnect(_on_entity_exited_sensor)








func _on_entity_entered_sensor(entity_node: EntityNode) -> void:

	var disposition = get_disposition(entity_node)

	if !disposition:

		disposition = _generate_disposition(entity_node)

	else:

		disposition.stop_expiration_timer()

	_evaluate_all(disposition)






func _on_entity_exited_sensor(entity_node: EntityNode) -> void:

	var disposition = get_disposition(entity_node)

	if disposition:

		disposition.start_expiration_timer()





func _on_behavior_evaluation_requested(behavior: Behavior) -> void:

	evaluation_cooldown = 0.0

	_evaluate_all()





func _process(delta: float) -> void:

	if !active:

		return

	if not evaluation_mode == EvaluationMode.NONE:

		if evaluation_timer > 0.0:

			evaluation_timer -= delta

			if evaluation_timer <= 0.0:

				_evaluate_all()

		if evaluation_cooldown > 0.0:

			evaluation_cooldown -= delta

	for disposition in dispositions:

		disposition.tick(delta)





func _physics_process(delta: float) -> void:

	if !active:

		return

	if current_behavior:

		current_behavior.tick(delta)