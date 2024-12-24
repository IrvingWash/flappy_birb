package flappy_bird

import rl "vendor:raylib"

GameState :: enum {
    Start,
    Play,
    Win,
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

game_state_start_draw :: proc(window_width: uint, window_height: uint) {
    text_length := uint(rl.MeasureText(START_GAME_TEXT, START_GAME_FONT_SIZE))

    rl.DrawText(
        START_GAME_TEXT,
        i32((window_width - text_length) / 2),
        i32((window_height - START_GAME_FONT_SIZE) / 2),
        START_GAME_FONT_SIZE,
        START_GAME_FONT_COLOR,
    )
}
