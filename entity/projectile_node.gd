class_name ProjectileNode extends ObjectNode


@export var on_screen_notifier: VisibleOnScreenNotifier2D


var projectile_owner: EntityNode

var ammunition_def: AmmunitionDef

var damage_package: DamagePackage






func _ready() -> void:

	on_screen_notifier.screen_exited.connect(_on_screen_exited)






func _connect_signals() -> void:

	combat_hitbox.hit_detected.connect(_on_hit_detected)



func _disconnect_signals() -> void:

	combat_hitbox.hit_detected.disconnect(_on_hit_detected)




func set_projectile_owner(_owner: EntityNode) -> void:

	projectile_owner = _owner

	combat_hitbox.ignore_list.append(_owner)





func set_trajectory(dir: Vector2) -> void:

	var override = VelocityModifier.new_override(dir * ammunition_def.projectile_speed)
	
	var movement_component = get_component(MovementComponent)

	movement_component.add_modifier(override)





static func from_ammunition(_ammunition_def: AmmunitionDef) -> ProjectileNode:

	var projectile_node = load("res://entity/projectile_node.tscn").instantiate()

	projectile_node.ammunition_def = _ammunition_def

	projectile_node.body_sprite.sprite_frames = _ammunition_def.sprite_frames

	projectile_node.body_sprite.position = _ammunition_def.body_sprite_position

	projectile_node.combat_hitbox.collision_shape.shape = _ammunition_def.hitbox_collision_shape

	projectile_node.combat_hitbox.collision_shape.position = _ammunition_def.hitbox_collision_position

	return projectile_node




func _on_screen_exited() -> void:

	queue_free()




func _on_hit_detected(hit_entity: EntityNode) -> void:

	hit_entity.receive_damage_package(damage_package)

	queue_free.call_deferred()