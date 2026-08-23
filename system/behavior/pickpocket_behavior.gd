class_name PickpocketBehavior extends Behavior


@export var target_defs: Array[EntityDef]


var pickpocket_complete:= false




func _evaluate(_target_disposition: Disposition) -> float:

	var evaluation = super(_target_disposition)

	if pickpocket_complete or IsHealthCriticalCondition.run({"entity_node": entity}):

		return 0.0

	if target_disposition:

		if entity.global_position.distance_to(target_disposition.target_entity.global_position) > 500.0:

			return 0.0

		return _get_final_multiplier(evaluation)

	return 0.0





func _start() -> void:

	super()

	navigation_component.set_target_entity(target_disposition.target_entity)





func _stop() -> void:

	super()

	navigation_component.set_target_entity(null)






func _get_final_multiplier(baseline: float) -> float:

	var final_multiplier = baseline 

	return final_multiplier * _get_fear_multiplier()





func _get_fear_multiplier() -> float:

	
	
	return super()




func _connect_signals() -> void:

	navigation_component.navigation_completed.connect(_on_navigation_completed)




func _disconnect_signals() -> void:

	navigation_component.navigation_completed.disconnect(_on_navigation_completed)









func receive_damage_package(damage_package: DamagePackage) -> void:

	if damage_package.source_entity == target_disposition.target_entity:

		pass










func _on_navigation_completed() -> void:

	if !target_disposition or !target_disposition.target_entity or pickpocket_complete: return

	var target_entity = target_disposition.target_entity

	if target_entity.state_machine.get_body_state() is BodyDodgingState:

		return

	var distance = entity.global_position.distance_to(target_entity.global_position)

	if distance <= 24.0:

		target_entity.state_machine.request_state(BodyRestrainedState)

		await Game.get_tree().create_timer(1.5).timeout

		target_entity.state_machine.request_state(BodyIdleState)

		pickpocket_complete = true



