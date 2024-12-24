package flappy_bird

import rl "vendor:raylib"

main :: proc() {
    create_window(WINDOW_WIDTH, WINDOW_HEIGHT, TITLE, TARGET_FPS)

    play()

    close_window()
}

play :: proc() {
    game_state, bird := start()

    for !rl.WindowShouldClose() {
        dt := f64(rl.GetFrameTime() * 10)

        update(&game_state, &bird, dt)

        render(game_state, bird)
    }
}

start :: proc() -> (GameState, Bird) {
    window_width := uint(rl.GetScreenWidth())
    window_height := uint(rl.GetScreenHeight())

    game_state := game_state_init()
    bird := bird_init(window_width, window_height)

    return game_state, bird
}

update :: proc(game_state: ^GameState, bird: ^Bird, dt: f64) {
    window_height := uint(rl.GetScreenHeight())

    if game_state^ == GameState.Start {
        game_state_toggle_play(game_state)
    }

    if game_state^ == GameState.Play {
        bird_move(bird, dt)
        bird_collide_with_world_edges(bird, window_height, game_state)
    }
}

render :: proc(game_state: GameState, bird: Bird) {
    window_width := uint(rl.GetScreenWidth())
    window_height := uint(rl.GetScreenHeight())

    rl.BeginDrawing()
    rl.ClearBackground(CLEAR_COLOR)

    bird_draw(bird)

    if game_state == GameState.Start {
        game_state_draw_start(window_width, window_height)
    }

    if game_state == GameState.GameOver {
        game_state_draw_game_over(window_width, window_height)
    }

    rl.EndDrawing()
}
