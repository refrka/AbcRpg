class_name BehaviorComponent extends Component


signal disposition_generated(disposition: Disposition)




var current_behavior: Behavior

var current_target_disposition: Disposition

var current_evaluated_disposition: Disposition



var attitude:= 0.0

var temperament:= 0.0


var dispositions: Array[Disposition]




var evaluation_timer:= 0.0

var evaluation_cooldown:= 0.0




func initialize(_entity: EntityNode) -> void:

	super(_entity)

	for behavior in _get_behaviors():

		behavior.initialize(entity, self)

		behavior.evaluation_requested.connect(_on_behavior_evaluation_requested.bind(behavior))

	





func _evaluate_all(disposition: Disposition = null) -> void:

	if evaluation_cooldown > 0.0:

		return

	evaluation_timer = 0.0

	current_evaluated_disposition = disposition

	var best_behavior: Behavior = null

	var best_score:= -INF

	var all_behaviors = _get_behaviors()

	for behavior in all_behaviors:

		var score = behavior.evaluate()

		if !best_behavior or score < best_score:

			best_behavior = behavior

			best_score = score

	_change_behavior(best_behavior)
	
	evaluation_timer = 3.0





func _change_behavior(new_behavior: Behavior) -> void:

	if new_behavior == current_behavior:

		return

	if current_behavior:

		current_behavior.stop()

	current_behavior = new_behavior

	current_behavior.start()





func get_behavior_profile() -> BehaviorProfile:

	return entity.entity_def.behavior_profile




func _get_behaviors() -> Array[Behavior]:

	var behavior_profile = get_behavior_profile()

	if behavior_profile:

		return behavior_profile.behaviors

	return []




func get_disposition(entity_node: EntityNode) -> Disposition:

	for disposition in dispositions:

		if disposition.target_entity == entity_node:

			return disposition
		
	return null





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

		_evaluate_all(disposition)

	else:

		disposition.stop_expiration_timer()






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