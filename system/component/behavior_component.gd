class_name BehaviorComponent extends Component



@export var initial_behavior: Behavior

@export var behaviors: Array[Behavior]

var current_behavior: Behavior










func _initialize(_entity: EntityNode) -> bool:

	if !super(_entity): return false

	for behavior in behaviors:

		behavior._initialize(entity)

	if initial_behavior:

		current_behavior = initial_behavior

	return true




func _evaluate_behaviors() -> Behavior:

	var chosen_behavior: Behavior = null

	var highest_evaluation:= -INF

	for behavior in behaviors:

		var evaluation = behavior._evaluate()

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






func _physics_process(delta: float) -> void:

	if !active: return

	if current_behavior and current_behavior.active:

		current_behavior._tick(delta)