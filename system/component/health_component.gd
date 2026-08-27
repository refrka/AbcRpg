class_name HealthComponent extends Component


var max_health: float

var current_health: float






func initialize(_entity: EntityNode) -> void:

	super(_entity)

	max_health = entity.entity_def.base_max_health

	current_health = max_health






func reduce_health(amount: float) -> void:

	var new_health = current_health - amount

	if new_health <= 0.0:

		current_health = 0.0

	else:

		current_health = new_health




func restore_health(amount: float) -> void:

	var new_health = current_health + amount

	if new_health > max_health:

		current_health = max_health

	else:

		current_health = new_health




func receive_damage_package(damage_package: DamagePackage) -> void:

	for damage_entry in damage_package.damage_entries:

		reduce_health(damage_entry.amount)