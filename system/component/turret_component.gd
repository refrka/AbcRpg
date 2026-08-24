class_name TurretComponent extends Component





@export var turret_config: TurretConfig

@export var ammunition_slot: EquipmentSlot

@export var attack_entry: AttackEntry




var firing_timer:= 0.0

var firing_timer_active:= false


var current_target: EntityNode








func _fire() -> void:

	var ammunition_data = ammunition_slot.item_data

	var ammunition_def = ammunition_data.item_def

	var projectile_node = ProjectileNode.from_ammunition(ammunition_def)

	var target_dir = entity.global_position.direction_to(current_target.global_position)

	projectile_node.rotation = target_dir.angle()

	projectile_node.set_trajectory(target_dir)

	projectile_node.global_position = entity.combat_origin.global_position

	projectile_node.damage_package = DamagePackage.from_attack_entry(attack_entry)

	projectile_node.set_projectile_owner(entity)

	entity.add_sibling.call_deferred(projectile_node)

	projectile_node._initialize()

	projectile_node._activate()

	firing_timer = turret_config.fire_rate





func _connect_signals() -> void:

	entity.vision_sensor.entity_entered_sensor.connect(_on_entity_entered_vision_sensor)

	entity.vision_sensor.entity_exited_sensor.connect(_on_entity_exited_vision_sensor)





func _disconnect_signals() -> void:

	entity.vision_sensor.entity_entered_sensor.disconnect(_on_entity_entered_vision_sensor)

	entity.vision_sensor.entity_exited_sensor.connect(_on_entity_exited_vision_sensor)





func _on_entity_entered_vision_sensor(entity_node: EntityNode) -> void:

	if !active: return

	current_target = entity_node

	if firing_timer_active: return

	firing_timer = turret_config.fire_rate

	# firing_timer_active = true

	# _fire()





func _on_entity_exited_vision_sensor(entity_node: EntityNode) -> void:

	if current_target == entity_node:

		current_target = entity.vision_sensor.get_nearest_entity()

		if !current_target:

			firing_timer_active = false







func _process(delta: float) -> void:

	if !active or !firing_timer_active:

		return

	if firing_timer > 0.0:

		firing_timer -= delta

		if firing_timer <= 0.0:

			# _fire()

			pass