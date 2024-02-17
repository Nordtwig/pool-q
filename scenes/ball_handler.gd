class_name BallHandler
extends Node

@export var texture_library: Array[Texture] = []


func get_texture_library_duplicate() -> Array[Texture]:
    return texture_library.duplicate()


func get_texture_library_size() -> int:
    return texture_library.size()


func get_texture_by_index(index: int) -> Texture:
    return texture_library[index]