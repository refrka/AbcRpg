class_name BehaviorComponent extends Component



@export var initial_behavior: Behavior

@export var behaviors: Array[Behavior]

@export var evaluation_time:= 2.0

var current_behavior: Behavior

var evaluation_timer:= 0.0




var attitude: float

var temperament: float




var dispositions: Array[Disposition]





func _initialize(_entity: EntityNode) -> bool:

	if !super(_entity): return false

	for behavior in behaviors:

		behavior._initialize(entity)

	if initial_behavior:

		current_behavior = initial_behavior

	attitude = entity.entity_def.baseline_attitude

	temperament = entity.entity_def.baseline_temperament

	return true




func receive_damage_package(damage_package: DamagePackage) -> void:

	if current_behavior and current_behavior.has_method("receive_damage_package"):

		current_behavior.receive_damage_package(damage_package)




func _connect_signals() -> void:

	entity.vision_sensor.entity_entered_sensor.connect(_on_entity_entered_vision_sensor)

	entity.vision_sensor.entity_exited_sensor.connect(_on_entity_exited_vision_sensor)

	for behavior in behaviors:

		behavior.evaluation_requested.connect(_on_behavior_evaluation_requested.bind(behavior))





func _disconnect_signals() -> void:

	entity.vision_sensor.entity_entered_sensor.disconnect(_on_entity_entered_vision_sensor)

	entity.vision_sensor.entity_exited_sensor.disconnect(_on_entity_exited_vision_sensor)

	for behavior in behaviors:

		behavior.evaluation_requested.disconnect(_on_behavior_evaluation_requested.bind(behavior))






func _choose_behavior(target_disposition: Disposition = null) -> void:

	var new_behavior = _evaluate_behaviors(target_disposition)

	if current_behavior and new_behavior != current_behavior:
		
		current_behavior._stop()

	current_behavior = new_behavior

	current_behavior._start()





func _evaluate_behaviors(target_disposition: Disposition = null) -> Behavior:

	evaluation_timer = 0.0

	var chosen_behavior: Behavior = null

	var highest_evaluation:= -INF

	for behavior in behaviors:

		var evaluation = behavior._evaluate(target_disposition)

		if !chosen_behavior or evaluation > highest_evaluation:

			chosen_behavior = behavior

			highest_evaluation = evaluation

	return chosen_behavior






func _generate_disposition(target_entity: EntityNode) -> void:

	var disposition = Disposition.create_new(target_entity)

	disposition.expired.connect(_on_disposition_expired.bind(disposition))

	dispositions.append(disposition)











func _get_disposition(target_entity: EntityNode) -> Disposition:

	for disposition in dispositions:

		if disposition.target_entity == target_entity:

			return disposition

	return null












func _activate() -> bool:

	if !super(): return false

	if !current_behavior:

		current_behavior = _evaluate_behaviors()

	current_behavior._start()

	return true




func _deactivate() -> bool:

	if !super(): return false

	if current_behavior:

		current_behavior._end()

	return true







func _on_entity_entered_vision_sensor(entity_node: EntityNode) -> void:

	var disposition = _get_disposition(entity_node)

	if !disposition:

		_generate_disposition(entity_node)

	else:

		disposition.stop_timer()

	_choose_behavior(disposition)



func _on_entity_exited_vision_sensor(entity_node: EntityNode) -> void:

	var disposition = _get_disposition(entity_node)

	if disposition:

		disposition.start_timer()



func _on_disposition_expired(disposition: Disposition) -> void:

	dispositions.erase(disposition)




func _on_behavior_evaluation_requested(_behavior: Behavior) -> void:

	_evaluate_behaviors()





func _physics_process(delta: float) -> void:

	if !active: return

	if current_behavior and current_behavior.active:

		current_behavior._tick(delta)

	for disposition in dispositions:

		disposition.tick(delta)

	if evaluation_timer < evaluation_time:

		evaluation_timer += delta

		if evaluation_timer >= evaluation_time:

			current_behavior = _evaluate_behaviors()