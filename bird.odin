package flappy_bird

import "core:math"
import rl "vendor:raylib"

Bird :: struct {
	position: Vector2,
	scale:    f64,
	rotation: f64,
	velocity: Vector2,
	size:     Vector2,
	speed:    f64,
	color:    rl.Color,
}

bird_init :: proc(window_width: uint, window_height: uint) -> Bird {
	return Bird {
		position = Vector2{x = f64(window_width / 4), y = f64(window_height / 2)},
		scale = BIRD_SCALE,
		rotation = 0,
		velocity = Vector2{0, 0},
		size = Vector2{x = BIRD_SIZE_X, y = BIRD_SIZE_Y},
		speed = BIRD_SPEED,
		color = BIRD_COLOR,
	}
}

bird_move :: proc(bird: ^Bird, dt: f64) {
	bird.velocity.y += BIRD_GRAVITY

	if rl.IsKeyDown(rl.KeyboardKey.SPACE) {
		bird.velocity.y = -bird.speed
	}

	bird.rotation = math.clamp(
		BIRD_MAX_UP_ROTATION,
		math.to_degrees(math.atan(bird.velocity.y / 10)),
		BIRD_MAX_DOWN_ROTATION,
	)

	add_vector2_in_place(&bird.position, scale_vector2(bird.velocity, dt))
}

bird_collide_with_world_edges :: proc(bird: ^Bird, window_height: uint, game_state: ^GameState) {
	if bird.position.y - bird.size.y / 2 <= 0 {
		bird.position.y = bird.size.y / 2

		return
	}

	if bird.position.y + bird.size.y / 2 >= f64(window_height) {
		game_state^ = GameState.GameOver
	}
}

bird_collide_with_pipes :: proc(bird: ^Bird, pipe_pair: PipePair, game_state: ^GameState) {
	bird_collider := rl.Rectangle {
		x      = f32(bird.position.x - bird.size.x / 2),
		y      = f32(bird.position.y - bird.size.y / 2),
		width  = f32(bird.size.x),
		height = f32(bird.size.y),
	}

	using pipe_pair

	is_colliding_with_upper := rl.CheckCollisionRecs(
		bird_collider,
		rl.Rectangle {
			x = f32(upper.position.x - upper.size.x / 2),
			y = f32(upper.position.y - upper.size.y / 2),
			width = f32(upper.size.x),
			height = f32(upper.size.y),
		},
	)

	if is_colliding_with_upper {
		game_state^ = GameState.GameOver

		return
	}

	is_colliding_with_lower := rl.CheckCollisionRecs(
		bird_collider,
		rl.Rectangle {
			x = f32(lower.position.x - lower.size.x / 2),
			y = f32(lower.position.y - lower.size.y / 2),
			width = f32(lower.size.x),
			height = f32(lower.size.y),
		},
	)

	if is_colliding_with_lower {
		game_state^ = GameState.GameOver

		return
	}
}

bird_draw :: proc(bird: Bird, sm: SpriteManager) {
	sprite := sm.sprites["bird_midflap"]

	rl.DrawTexturePro(
		texture = sprite,
		source = rl.Rectangle {
			x = 0,
			y = 0,
			width = f32(sprite.width),
			height = f32(sprite.height),
		},
		dest = rl.Rectangle {
			x = f32(bird.position.x),
			y = f32(bird.position.y),
			width = f32(bird.size.x),
			height = f32(bird.size.y),
		},
		origin = rl.Vector2{f32(bird.size.x * BIRD_SCALE / 2), f32(bird.size.y * BIRD_SCALE / 2)},
		rotation = f32(bird.rotation),
		tint = rl.WHITE,
	)
}
