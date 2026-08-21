class_name AttackConfig extends Resource



@export var attack_set: Array[AttackEntry]



func get_attack_entry(index: int) -> AttackEntry:

	var attack_entry: AttackEntry = null

	if attack_set.size() - 1 >= index:

		attack_entry = attack_set[index]

	return attack_entry