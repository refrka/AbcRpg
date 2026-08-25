class_name BehaviorComponent extends Component










@export var evaluation_time:= 2.0

var behavior_profile: BehaviorProfile

var current_behavior: Behavior

var evaluation_timer:= 0.0

var evaluation_cooldown:= 0.0



var attitude: float

var temperament: float



var current_target_disposition: Disposition

var behaviors: Array[Behavior]

var dispositions: Array[Disposition]





func _initialize(_entity: EntityNode) -> bool:

	if !_entity.entity_def.behavior_profile:

		return false

	if !super(_entity): return false

	behavior_profile = entity.entity_def.behavior_profile

	attitude = entity.entity_def.baseline_attitude

	temperament = entity.entity_def.baseline_temperament

	for behavior in behavior_profile.behaviors:

		var _behavior = behavior.duplicate(true)

		behaviors.append(_behavior)

		_behavior._initialize(entity, self)

	return true








func get_disposition(entity_node: EntityNode) -> Disposition:

	for disposition in dispositions: 

		if disposition.target_entity == entity_node:

			return disposition

	return _generate_disposition(entity_node)








func _evaluate_all(target_disposition: Disposition = null) -> void:

	if evaluation_cooldown > 0.0: return

	evaluation_cooldown = 0.5

	var best_behavior: Behavior = null

	var best_score:= -INF

	var best_disposition: Disposition = null

	for behavior in behaviors:

		print("evaluating ", behavior.get_display_name())

		var score:= 0.0

		var chosen_disposition = target_disposition

		if behavior.requires_disposition and !dispositions.is_empty():

			for disposition in dispositions:

				var disposition_score = behavior._evaluate(disposition)

				if disposition_score > score:

					score = disposition_score

					chosen_disposition = disposition
		
		else:

			score = behavior._evaluate(chosen_disposition)

			var attitude_multiplier = _get_attitude_multiplier(behavior)

			var temperament_multiplier = _get_temperament_multiplier(behavior)

			print("score before multiply: ", score)

			score *= attitude_multiplier * temperament_multiplier

			print("score after: ", score)

		if score > best_score:

			best_score = score

			best_behavior = behavior

			best_disposition = chosen_disposition

	_change_behavior(best_behavior, best_disposition)

	evaluation_timer = evaluation_time

			




func _change_behavior(new_behavior: Behavior, target_disposition: Disposition = null) -> void:

	if new_behavior == current_behavior:

		return

	if current_behavior:
		
		current_behavior._stop(target_disposition)

	current_behavior = new_behavior

	current_behavior._start(target_disposition)


















func receive_damage_package(damage_package: DamagePackage) -> void:

	if current_behavior:

		current_behavior._receive_damage_package(damage_package)

	var disposition = get_disposition(damage_package.source_entity)

	if !disposition:

		disposition = _generate_disposition(damage_package.source_entity)

	var reaction_tag = entity.entity_def.behavior_profile.get_reaction_tag(ReceivedDamageTag)

	if reaction_tag:

		_apply_reaction_tag(reaction_tag, disposition)

	_evaluate_all(disposition)






func _generate_disposition(target_entity: EntityNode) -> Disposition:

	var disposition = Disposition.create_new(target_entity)

	disposition.expired.connect(_on_disposition_expired.bind(disposition))

	dispositions.append(disposition)

	return disposition




func _add_disposition(disposition: Disposition) -> void:

	if !dispositions.has(disposition):

		dispositions.append(disposition)









func _apply_reaction_tag(reaction_tag: ReactionTag, disposition: Disposition = null) -> void:

	attitude += reaction_tag.attitude_delta

	temperament += reaction_tag.temperament_delta

	if disposition:

		disposition.apply_reaction_tag(reaction_tag)

	_evaluate_all()

	





func _get_attitude_multiplier(behavior: Behavior) -> float:

	return behavior._get_curve_sample(behavior.attribute_remap.attitude_curve, attitude)






func _get_temperament_multiplier(behavior: Behavior) -> float:

	return behavior._get_curve_sample(behavior.attribute_remap.temperament_curve, temperament)









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





	





func _activate() -> bool:

	if !super(): return false

	if !current_behavior:

		_evaluate_all()

	if current_behavior:

		current_behavior._activate()

	return true




func _deactivate() -> bool:

	if !super(): return false

	if current_behavior:

		current_behavior._deactivate()

	return true









func _on_entity_entered_vision_sensor(entity_node: EntityNode) -> void:

	var disposition = get_disposition(entity_node)

	if !disposition:

		disposition = _generate_disposition(entity_node)

	else:

		disposition.stop_timer()

	_evaluate_all(disposition)



func _on_entity_exited_vision_sensor(entity_node: EntityNode) -> void:

	var disposition = get_disposition(entity_node)

	if disposition:

		disposition.start_timer()

	_evaluate_all(disposition)




func _on_disposition_expired(disposition: Disposition) -> void:

	dispositions.erase(disposition)




func _on_behavior_evaluation_requested(_behavior: Behavior) -> void:

	_evaluate_all()





func _physics_process(delta: float) -> void:

	if !active: return

	if evaluation_cooldown > 0.0:

		evaluation_cooldown -= delta

	if current_behavior and current_behavior.active:

		current_behavior._tick(delta)

	for disposition in dispositions:

		disposition.tick(delta)

	if evaluation_timer > 0.0:

		evaluation_timer -= delta

		if evaluation_timer <= 0.0:

			_evaluate_all()