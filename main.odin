package flappy_bird

import rl "vendor:raylib"

main :: proc() {
    create_window(WINDOW_WIDTH, WINDOW_HEIGHT, TITLE, TARGET_FPS)

    play()

    close_window()
}

play :: proc() {
    game_state, bird, ppg, pipes := start()

    for !rl.WindowShouldClose() {
        dt := f64(rl.GetFrameTime() * 10)
        time := rl.GetTime() * 1000

        update(&game_state, &bird, &ppg, &pipes, dt, time)

        render(game_state, bird, pipes)
    }
}

start :: proc() -> (GameState, Bird, PipePairGenerator, [dynamic]PipePair) {
    window_width := uint(rl.GetScreenWidth())
    window_height := uint(rl.GetScreenHeight())

    game_state := game_state_init()
    bird := bird_init(window_width, window_height)
    ppg := PipePairGenerator{}
    pipes: [dynamic]PipePair

    return game_state, bird, ppg, pipes
}

update :: proc(game_state: ^GameState, bird: ^Bird, ppg: ^PipePairGenerator, pipes: ^[dynamic]PipePair, dt: f64, time: f64) {
    window_width := uint(rl.GetScreenWidth())
    window_height := uint(rl.GetScreenHeight())

    if game_state^ == GameState.Start {
        game_state_toggle_play(game_state)
    }

    if game_state^ == GameState.Play {
        bird_move(bird, dt)
        bird_collide_with_world_edges(bird, window_height, game_state)

        for &pipe_pair in pipes {
            pipe_pair_move(&pipe_pair, dt)
        }

        pipe_pair, ok := ppg_generate(ppg, window_width, window_height, time).?
        if ok {
            append(pipes, pipe_pair)
        }
    }
}

render :: proc(game_state: GameState, bird: Bird, pipes: [dynamic]PipePair) {
    window_width := uint(rl.GetScreenWidth())
    window_height := uint(rl.GetScreenHeight())

    rl.BeginDrawing()
    rl.ClearBackground(CLEAR_COLOR)

    bird_draw(bird)

    for pipe_pair in pipes {
        pipe_pair_draw(pipe_pair)
    }

    if game_state == GameState.Start {
        game_state_draw_start(window_width, window_height)
    }

    if game_state == GameState.GameOver {
        game_state_draw_game_over(window_width, window_height)
    }

    rl.EndDrawing()
}
