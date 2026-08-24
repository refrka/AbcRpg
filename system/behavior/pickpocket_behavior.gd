class_name PickpocketBehavior extends Behavior


@export var target_defs: Array[EntityDef]


var pickpocket_complete:= false

var cooldown:= 0.0




func _evaluate(_target_disposition: Disposition = null) -> float:

	var evaluation = super(_target_disposition)

	if cooldown > 0.0:

		cooldown -= 1.0

		return 0.0

	if pickpocket_complete or IsHealthCriticalCondition.run({"entity_node": entity}):

		return 0.0

	if !_target_disposition:

		var behavior_component = entity.get_component(BehaviorComponent)

		var highest_disposition_evaluation:= 0.0

		for disposition in behavior_component.dispositions:

			if not disposition.target_entity is CharacterNode:

				continue

			var disposition_evaluation = _get_final_multiplier(evaluation, disposition)

			if disposition_evaluation > highest_disposition_evaluation:

				highest_disposition_evaluation = disposition_evaluation

		return highest_disposition_evaluation

	else:

		if entity.global_position.distance_to(_target_disposition.target_entity.global_position) > 500.0:

			return 0.0

		return _get_final_multiplier(evaluation, _target_disposition)





func _start(_target_disposition: Disposition = null) -> void:

	super()

	target_disposition = _target_disposition

	navigation_component.set_target_entity(target_disposition.target_entity)





func _stop() -> void:

	super()

	target_disposition = null

	navigation_component.set_target_entity(null)






func _get_final_multiplier(baseline: float, _target_disposition: Disposition = null) -> float:

	var final_multiplier = baseline 

	return final_multiplier * _get_fear_multiplier(_target_disposition)





func _get_fear_multiplier(_target_disposition: Disposition = null) -> float:
	
	return super(_target_disposition)




func _connect_signals() -> void:

	navigation_component.navigation_completed.connect(_on_navigation_completed)




func _disconnect_signals() -> void:

	navigation_component.navigation_completed.disconnect(_on_navigation_completed)








func _execute_pickpocket(restrained_state: BodyRestrainedState) -> void:

	if !_can_pickpocket(): return

	cooldown = 3.0

	var target_inventory = target_disposition.target_entity.inventory

	var data_list = target_inventory.get_non_empty_data().filter(func(d): return d.item_def.can_pickpocket)

	for i in range(randi_range(1,10)):

		var random_index = randi_range(0, data_list.size() - 1)

		var item_data = data_list[random_index]

		if item_data.is_empty():

			continue

		var node_item_data = ItemData.new()

		node_item_data.set_data(item_data.item_def, 1)

		item_data.remove_amount(1)

		var item_node = ItemNode.create_new(node_item_data)

		var pull_dir = target_disposition.target_entity.global_position.direction_to(entity.global_position)

		var pull_dist = pull_dir * 75

		item_node.global_position = entity.global_position + pull_dist + (Vector2(randf_range(-1.0,1.0), randf_range(-1.0, 1.0)) * 20)

		entity.add_sibling(item_node)

		item_node._initialize()

		item_node._activate()

	# pickpocket_complete = true

	target_disposition.target_entity.state_machine.request_state(BodyIdleState)

	restrained_state.break_free.disconnect(_on_entity_break_free)

	target_disposition = null

	evaluation_requested.emit()






func _fail_pickpocket(restrained_state: BodyRestrainedState) -> void:

	cooldown = 3.0

	target_disposition.target_entity.state_machine.request_state(BodyIdleState)

	restrained_state.break_free.disconnect(_on_entity_break_free)

	evaluation_requested.emit()





func _can_pickpocket() -> bool:

	if !target_disposition or !target_disposition.target_entity or pickpocket_complete or cooldown > 0.0: return false

	return true


	






func receive_damage_package(damage_package: DamagePackage) -> void:

	if damage_package.source_entity == target_disposition.target_entity:

		pass










func _on_navigation_completed() -> void:

	if !_can_pickpocket(): return

	var target_entity = target_disposition.target_entity

	if target_entity.state_machine.get_body_state() is BodyDodgingState:

		return

	var distance = entity.global_position.distance_to(target_entity.global_position)

	if distance <= 24.0:

		var restrained_state = target_entity.state_machine.request_state(BodyRestrainedState)

		if restrained_state:

			restrained_state.break_free.connect(_on_entity_break_free.bind(restrained_state))

		await Game.get_tree().create_timer(1.5).timeout

		if active:
			
			_execute_pickpocket(restrained_state)





func _on_entity_break_free(restrained_state: BodyRestrainedState) -> void:

	_fail_pickpocket(restrained_state)


