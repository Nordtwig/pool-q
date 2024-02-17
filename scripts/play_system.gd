extends Node3D

@export var _cue_ball: RigidBody3D
@export var _aim_container: Node3D
@export var _cue_stick: Node3D
@export var _stick_animation_player: AnimationPlayer

@export var _stick_z_sensitivity: float = 0.01
@export var _stick_min_z: float = -0.005
@export var _stick_max_z: float = 0.5
@export var _shot_power_min: float = 0.1
@export var _shot_power_max: float = 5.0

var _shot_percent: float = 0.0


func _ready() -> void:
    # Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
    _cue_ball.position = BilliardTable.HEAD_SPOT


func _process(_delta) -> void:
    _handle_shot_input()
        
    _aim_container.position = _cue_ball.position


func _input(event: InputEvent) -> void:
    var mouse_motion = event as InputEventMouseMotion
    
    if mouse_motion:
        _aim_container.rotation_degrees.y += mouse_motion.relative.x
        _shot_percent += mouse_motion.relative.y * _stick_z_sensitivity
        _shot_percent = clamp(_shot_percent, 0, 1)
        _cue_stick.position.z = lerp(_stick_min_z, _stick_max_z, _shot_percent)

        # _cue_stick.position.z += mouse_motion.relative.y * _stick_z_sensitivity
        # _cue_stick.position.z = clamp(_cue_stick.position.z, _stick_min_z, _stick_max_z)


func _handle_shot_input():
    if Input.is_action_just_pressed("shoot"):
        _stick_animation_player.play("shoot_stick")


# executed by "shoot_stick" animation in _handle_shot_input
func _strike_ball():
    var stick_direction = -_aim_container.basis.z
    var shot_power: float = lerp(_shot_power_min, _shot_power_max, _shot_percent) as float
    var shot_vector = stick_direction * shot_power
    _cue_ball.apply_central_impulse(shot_vector)

    _cue_stick.visible = false

    GameEvents.cue_ball_hit.emit()
