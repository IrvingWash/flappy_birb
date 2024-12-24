package flappy_bird

import rl "vendor:raylib"

GameState :: enum {
	Start,
	Play,
	GameOver,
}

game_state_init :: proc() -> GameState {
	return GameState.Start
}

game_state_toggle_play :: proc(game_state: ^GameState) {
	if rl.IsKeyPressed(rl.KeyboardKey.SPACE) {
		game_state^ = GameState.Play
	}
}

game_state_draw_start :: proc(window_width: uint, window_height: uint) {
	text_length := uint(rl.MeasureText(START_GAME_TEXT, START_GAME_FONT_SIZE))

	rl.DrawText(
		START_GAME_TEXT,
		i32((window_width - text_length) / 2),
		i32((window_height - START_GAME_FONT_SIZE) / 2),
		START_GAME_FONT_SIZE,
		START_GAME_FONT_COLOR,
	)
}

game_state_draw_game_over :: proc(window_width: uint, window_height: uint) {
	text_length := uint(rl.MeasureText(GAME_OVER_TEXT, GAME_OVER_FONT_SIZE))

	rl.DrawText(
		GAME_OVER_TEXT,
		i32((window_width - text_length) / 2),
		i32((window_height - GAME_OVER_FONT_SIZE) / 2),
		GAME_OVER_FONT_SIZE,
		GAME_OVER_FONT_COLOR,
	)
}
