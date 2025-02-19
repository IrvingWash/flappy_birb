package flappy_bird

import rl "vendor:raylib"

main :: proc() {
	create_window(WINDOW_WIDTH, WINDOW_HEIGHT, TITLE, TARGET_FPS)

	play()

	close_window()
}

play :: proc() {
	game_state, bird, ppg, pipes, background, score, bird_animator := start()
	sprite_manager := sm_init()
	load_sprites(&sprite_manager)

	for !rl.WindowShouldClose() {
		dt := f64(rl.GetFrameTime() * 10)
		time := rl.GetTime() * 1000

		update(&game_state, &bird, &ppg, &pipes, &score, dt, time, sprite_manager, &bird_animator)

		render(game_state, bird, pipes, background, score, sprite_manager, bird_animator)
	}

	sm_destroy(sprite_manager)
	delete(pipes)
}

start :: proc() -> (GameState, Bird, PipePairGenerator, [dynamic]PipePair, Background, Score, BirdAnimator) {
	window_width := uint(rl.GetScreenWidth())
	window_height := uint(rl.GetScreenHeight())

	game_state := game_state_init()
	bird := bird_init(window_width, window_height)
	ppg := ppg_init()
	pipes: [dynamic]PipePair
	background := bkg_init(window_width, window_height)
	score := score_init()
	ba := ba_init()

	return game_state, bird, ppg, pipes, background, score, ba
}

update :: proc(
	game_state: ^GameState,
	bird: ^Bird,
	ppg: ^PipePairGenerator,
	pipes: ^[dynamic]PipePair,
	score: ^Score,
	dt: f64,
	time: f64,
	sm: SpriteManager,
	ba: ^BirdAnimator,
) {
	window_width := uint(rl.GetScreenWidth())
	window_height := uint(rl.GetScreenHeight())

	if game_state^ == GameState.Start {
		game_state_toggle_play(game_state)
	}

	if game_state^ == GameState.Play {
		bird_move(bird, dt)
		bird_collide_with_world_edges(bird, window_height, game_state)
		bird_animate(ba, sm, time)

		for pipe_pair in pipes {
			bird_collide_with_pipes(bird, pipe_pair, game_state)
		}

		for &pipe_pair in pipes {
			pipe_pair_move(&pipe_pair, dt)
		}

		new_pipe_pair, ok := ppg_generate(ppg, window_width, window_height, time).?
		if ok {
			append(pipes, new_pipe_pair)
		}

		score_update(score, bird^, pipes^)
	}
}

render :: proc(
	game_state: GameState,
	bird: Bird,
	pipes: [dynamic]PipePair,
	background: Background,
	score: Score,
	sm: SpriteManager,
	ba: BirdAnimator,
) {
	window_width := uint(rl.GetScreenWidth())
	window_height := uint(rl.GetScreenHeight())

	rl.BeginDrawing()
	rl.ClearBackground(CLEAR_COLOR)

	bkg_draw(background, sm, window_width, window_height)

	for pipe_pair in pipes {
		pipe_pair_draw(pipe_pair, sm)
	}

	bird_draw(bird, sm, ba)

	draw_score(score, window_height)

	if game_state == GameState.Start {
		game_state_draw_start(window_width, window_height)
	}

	if game_state == GameState.GameOver {
		game_state_draw_game_over(window_width, window_height)
	}

	rl.EndDrawing()
}

load_sprites :: proc(sm: ^SpriteManager) {
	sm_load_sprite(sm, "bkg", "assets/background_day.png")
	sm_load_sprite(sm, "bird_upflap", "assets/yellowbird_upflap.png")
	sm_load_sprite(sm, "bird_midflap", "assets/yellowbird_midflap.png")
	sm_load_sprite(sm, "bird_downflap", "assets/yellowbird_downflap.png")
	sm_load_sprite(sm, "pipe", "assets/pipe_green.png")
}
