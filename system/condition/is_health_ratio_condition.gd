class_name IsHealthRatioCondition extends Condition



@export var ratio:= 0.0



func evaluate(_data:= {}) -> bool:

	super(_data)

	if !data.has("entity_node"):

		return false

	var entity_node = data["entity_node"]

	if data.has("ratio"):

		ratio = data["ratio"]

	var health_component = entity_node.get_component(HealthComponent)

	var health_ratio = health_component.get_ratio()

	return ratio >= health_ratio




static func run(_data:= {}) -> bool:

	var condition = IsHealthRatioCondition.new()

	return condition.evaluate(_data)