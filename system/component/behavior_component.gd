class_name BehaviorComponent extends Component



@export var initial_behavior: Behavior

@export var behaviors: Array[Behavior]

@export var evaluation_time:= 2.0

var current_behavior: Behavior

var evaluation_timer:= 0.0









func _initialize(_entity: EntityNode) -> bool:

	if !super(_entity): return false

	for behavior in behaviors:

		behavior._initialize(entity)

	if initial_behavior:

		current_behavior = initial_behavior

	return true




func _connect_signals() -> void:

	entity.vision_sensor.entity_entered_sensor.connect(_on_entity_entered_vision_sensor)




func _choose_behavior(_data:= {}) -> void:

	var new_behavior = _evaluate_behaviors(_data)

	if current_behavior and new_behavior != current_behavior:
		
		current_behavior._stop()

	current_behavior = new_behavior

	current_behavior._start()





func _evaluate_behaviors(_data:= {}) -> Behavior:

	evaluation_timer = 0.0

	var chosen_behavior: Behavior = null

	var highest_evaluation:= -INF

	for behavior in behaviors:

		var evaluation = behavior._evaluate(_data)

		if !chosen_behavior or evaluation > highest_evaluation:

			chosen_behavior = behavior

			highest_evaluation = evaluation

	return chosen_behavior




func _activate() -> bool:

	if !super(): return false

	if !current_behavior:

		current_behavior = _evaluate_behaviors()

	current_behavior._start()

	return true



func _deactivate() -> bool:

	if !super(): return false

	if current_behavior:

		current_behavior._end()

	return true





func _on_entity_entered_vision_sensor(entity_node: EntityNode) -> void:

	_choose_behavior({"entity_node": entity_node})





func _physics_process(delta: float) -> void:

	if !active: return

	if current_behavior and current_behavior.active:

		current_behavior._tick(delta)

	if evaluation_timer < evaluation_time:

		evaluation_timer += delta

		if evaluation_timer >= evaluation_time:

			current_behavior = _evaluate_behaviors()