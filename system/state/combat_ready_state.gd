class_name CombatReadyState extends CombatState





var ready_timer:= 0.0

var timer_active:= false













func _end_ready() -> void:

	state_machine.request_state(CombatIdleState)









func _tick(delta: float) -> void:

	if !active or !timer_active: return

	if ready_timer > 0.0:

		ready_timer -= delta

		if ready_timer <= 0.0:

			_end_ready()

