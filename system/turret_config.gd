class_name TurretConfig extends Resource



enum TurretMode {

	FIXED,

	TARGET

}



@export var allowed_ammunition: Array[AmmunitionDef]

@export var turret_mode: TurretMode

@export var fire_rate:= 1.0