package flappy_bird

import rl "vendor:raylib"

// Window
WINDOW_WIDTH :: 800
WINDOW_HEIGHT :: 600
TITLE :: "Flappy Bird"
TARGET_FPS :: 60
CLEAR_COLOR :: rl.BLUE

// Status screens
START_GAME_TEXT :: "Press SPACE to start"
START_GAME_FONT_SIZE :: 36
START_GAME_FONT_COLOR :: rl.GREEN
GAME_OVER_TEXT :: "Game Over"
GAME_OVER_FONT_SIZE :: 36
GAME_OVER_FONT_COLOR :: rl.RED

// Bird
BIRD_SCALE :: 1
BIRD_SIZE_X :: 70
BIRD_SIZE_Y :: 70
BIRD_COLOR :: rl.YELLOW
BIRD_GRAVITY :: 30
BIRD_SPEED :: 50

// Pipes
PIPE_SPEED :: 50
PIPE_WIDTH :: 50
PIPE_SCALE :: 1
PIPE_GATE_HEIGHT :: WINDOW_WIDTH / 4
PIPE_COLOR :: rl.GREEN
PIPE_GENERATOR_DELAY_MS :: 2000
