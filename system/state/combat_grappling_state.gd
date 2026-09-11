class_name CombatGrapplingState extends CombatState





var movement_component: MovementComponent

var speed_modifier: SpeedModifier



func _initialize(_entity: EntityNode, _state_machine: StateMachine) -> void:

	super(_entity, _state_machine)

	movement_component = entity.get_component(MovementComponent)





func _enter() -> void:

	speed_modifier = SpeedModifier.new_multiplier(0.0, -1.0)

	movement_component.add_modifier(speed_modifier)




func _exit() -> void:

	if speed_modifier:

		movement_component.remove_modifier(speed_modifier)

		speed_modifier = null