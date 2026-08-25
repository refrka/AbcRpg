class_name IsHealthCriticalCondition extends Condition



@export var critical_ratio:= 0.25






func _evaluate(_data:= {}) -> bool:

	super(_data)

	var entity_node = data["entity_node"]

	if data.has("critical_ratio"):

		critical_ratio = data["critical_ratio"]

	var health_component = entity_node.get_component(HealthComponent)

	return health_component.get_ratio() < critical_ratio





static func run(_data:= {}) -> bool:

	var condition = IsHealthCriticalCondition.new()

	return condition._evaluate(_data)