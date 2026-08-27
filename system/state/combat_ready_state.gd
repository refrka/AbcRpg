class_name CombatReadyState extends CombatState







var ready_timer:= 0.0




func _enter() -> void:

	super()

	ready_timer = 3.0




func _exit() -> void:

	super()

	ready_timer = 0.0





func _expire_ready() -> void:

	_transition_to(CombatIdleState)











func _tick(delta: float) -> void:

	if !active:

		return

	if ready_timer > 0.0:

		ready_timer -= delta

		if ready_timer <= 0.0:


			_expire_ready()