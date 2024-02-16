extends RigidBody3D

@export var _texture: Texture2D


func _ready() -> void:
    var new_material = StandardMaterial3D.new()
    new_material.albedo_texture = _texture
    $BallMesh.material_override = new_material
