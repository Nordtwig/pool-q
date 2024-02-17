class_name Ball
extends RigidBody3D

const BALL_RADIUS = 0.027

@export var _texture: Texture2D


func _ready() -> void:
    _apply_new_material()


func _apply_new_material() -> void:
    var new_material = StandardMaterial3D.new()
    new_material.albedo_texture = _texture
    $BallMesh.material_override = new_material


func set_up_ball(ball_texture: Texture, ball_position: Vector3) -> void:
    self.global_position = ball_position

    _texture = ball_texture
    _apply_new_material()
