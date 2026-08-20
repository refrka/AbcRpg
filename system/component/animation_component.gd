class_name AnimationComponent extends Component






var blendspace_paths:= {

	"moving": "parameters/MovingState/MovingBlend/blend_position"

}




var body_state_playback: AnimationNodeStateMachinePlayback

var combat_state_playback: AnimationNodeStateMachinePlayback




var flip_h:= false

var y_dir:= ""










func set_body_dir(dir: Vector2, moving: bool) -> void:

	entity.body_sprite.flip_h = dir.x < 0.0

	flip_h = entity.body_sprite.flip_h

	var animation = "idle_" if !moving else "moving_"

	if dir.y >= 0.0:

		y_dir = "down"

		animation += y_dir

	else:

		y_dir = "up"

		animation += y_dir

	entity.body_sprite.play(animation)

