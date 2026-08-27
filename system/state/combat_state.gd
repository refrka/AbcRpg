class_name CombatState extends State


@export var body_state_override:= false



var combat_component: CombatComponent



func _initialize(_entity: EntityNode, _state_machine: StateMachine) -> void:

	super(_entity, _state_machine)

	combat_component = entity.get_component(CombatComponent)