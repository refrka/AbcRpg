class_name IsHealthCriticalCondition extends Condition





func _evaluate(_data:= {}) -> bool:

	super(_data)

	var entity_node = data["entity_node"]

	var health_component = entity_node.get_component(HealthComponent)

	return health_component.is_critical()





static func run(_data:= {}) -> bool:

	var condition = IsHealthCriticalCondition.new()

	return condition._evaluate(_data)