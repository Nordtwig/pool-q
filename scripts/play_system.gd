extends Node3D

@export var _cue_ball: RigidBody3D
@export var _aim_container: Node3D
@export var _cue_stick: Node3D
@export var _stick_animation_player: AnimationPlayer

@export var _stick_z_sensitivity: float = 0.01
@export var _stick_min_z: float = -0.005
@export var _stick_max_z: float = 0.5


func _ready() -> void:
    # Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
    pass


func _process(_delta) -> void:
    _handle_shot_input()
        
    _aim_container.position = _cue_ball.position


func _input(event: InputEvent) -> void:
    var mouse_motion = event as InputEventMouseMotion
    
    if mouse_motion:
        _aim_container.rotation_degrees.y += mouse_motion.relative.x
        _cue_stick.position.z += mouse_motion.relative.y * _stick_z_sensitivity
        _cue_stick.position.z = clamp(_cue_stick.position.z, _stick_min_z, _stick_max_z)


func _handle_shot_input():
    if Input.is_action_just_pressed("shoot"):
        _stick_animation_player.play("shoot_stick")


# executed by "shoot_stick" animation in _handle_shot_input
func _strike_ball():
    var stick_direction = -_aim_container.basis.z
    _cue_stick.visible = false
    _cue_ball.apply_central_impulse(stick_direction)
