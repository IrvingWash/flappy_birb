package flappy_bird

Vector2 :: struct {
	x, y: f64,
}

add_vector2_in_place :: proc(lhs: ^Vector2, rhs: Vector2) {
	lhs.x += rhs.x
	lhs.y += rhs.y
}

scale_vector2 :: proc(lhs: Vector2, rhs: f64) -> Vector2 {
	return Vector2{lhs.x * rhs, lhs.y * rhs}
}
