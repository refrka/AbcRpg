class_name AnimationComponent extends Component






var blendspace_paths:= {

	"moving": "parameters/MovingState/MovingBlend/blend_position"

}




var body_state_playback: AnimationNodeStateMachinePlayback

var combat_state_playback: AnimationNodeStateMachinePlayback













func set_body_dir(dir: Vector2, moving: bool) -> void:

	entity.body_sprite.flip_h = dir.x < 0.0

	var animation = "idle_" if !moving else "moving_"

	if dir.y >= 0.0:

		animation += "down"

	else:

		animation += "up"

	entity.body_sprite.play(animation)

