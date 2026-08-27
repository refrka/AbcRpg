class_name BodyState extends State




var animation_component: AnimationComponent



func _initialize(_entity: EntityNode, _state_machine: StateMachine) -> void:

	super(_entity, _state_machine)

	animation_component = entity.get_component(AnimationComponent)