class_name WeaponDef extends EquipmentDef



enum WeaponType {

	MELEE,

	RANGED

}



@export var weapon_type: WeaponType

@export var default_attack_config: AttackConfig

@export var allowed_ammunitions: Array[AmmunitionDef]