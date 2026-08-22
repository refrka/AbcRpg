class_name CombatFlinchState extends CombatState





func _enter() -> void:

	super()

	transition_to(BodyFlinchState)


