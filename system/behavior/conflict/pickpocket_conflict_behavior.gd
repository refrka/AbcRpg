class_name PickpicketConflictBehavior extends ConflictBehavior



var pickpocket_complete:= false

var grappled_state: CombatGrappledState

var pickpocket_target: EntityNode

var cooldown:= 0.0

var timer:= 0.0

var is_pickpocketing:= false





func evaluate(disposition: Disposition = null) -> float:

	var score = super(disposition)

	if !disposition and !last_evaluated_disposition:

		return 0.0

	if pickpocket_complete:

		return 0.0

	pickpocket_target = last_evaluated_disposition.target_entity

	if !pickpocket_target.inventory:

		return 0.0

	return score






func stop() -> void:

	if grappled_state and grappled_state.broke_free.is_connected(_on_broke_free):

		grappled_state.broke_free.disconnect(_on_broke_free)





func _try_pickpocket() -> void:

	_start_pickpocket()






func _start_pickpocket() -> void:

	is_pickpocketing = true

	grappled_state = pickpocket_target.state_machine.request_state(CombatGrappledState)

	entity.state_machine.request_state(CombatGrapplingState)

	grappled_state.broke_free.connect(_on_broke_free)






func _complete_pickpocket() -> void:

	timer = 0.0

	cooldown = 0.0

	pickpocket_complete = true

	last_evaluated_disposition.update_fear(0.5)

	_end_pickpocket()

	evaluation_requested.emit()





func _end_pickpocket() -> void:

	is_pickpocketing = false

	grappled_state.broke_free.disconnect(_on_broke_free)

	grappled_state = null

	pickpocket_target.state_machine.request_state(CombatReadyState)

	entity.state_machine.request_state(CombatReadyState)





func _interrupt_pickpocket() -> void:

	_end_pickpocket()

	_start_cooldown()






func _start_cooldown() -> void:

	cooldown = 5.0

	if pickpocket_target:

		var direction = pickpocket_target.get_direction_to(entity)

		var target_position = entity.global_position + direction * 250

		navigation_component.set_target_position(target_position)






func _on_broke_free() -> void:

	_interrupt_pickpocket()






func tick(delta: float) -> void:

	if pickpocket_target and !pickpocket_complete and !is_pickpocketing:

		if cooldown <= 0.0:

			var distance = entity.get_distance_to(pickpocket_target)

			if distance <= 16.0:

				_try_pickpocket()

			else:

				navigation_component.set_target_position(pickpocket_target.global_position)

	if cooldown > 0.0:
		
		cooldown -= delta

	if is_pickpocketing:

		timer += delta

		if timer >= 3.0:

			_complete_pickpocket()

			