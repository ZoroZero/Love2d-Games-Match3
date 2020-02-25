require 'src/Ultil'

-- WINDOW DIMENSIONS
WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

-- VIRTUAL DIMENSIONS
VIRTUAL_WIDTH = 512;
VIRTUAL_HEIGHT = 288;

-- SOUND
game_Sounds = {
    ['confirm'] = love.audio.newSource('assets/sounds/confirm.wav', 'static'),
    ['clock'] = love.audio.newSource('assets/sounds/clock.wav', 'static'),
    ['error'] = love.audio.newSource('assets/sounds/error.wav', 'static'),
    ['game-over'] = love.audio.newSource('assets/sounds/game-over.wav', 'static'),
    ['match'] = love.audio.newSource('assets/sounds/match.wav', 'static'),
    ['music'] = love.audio.newSource('assets/sounds/music.mp3', 'static'),
    ['music2'] = love.audio.newSource('assets/sounds/music2.mp3', 'static'),
    ['music3'] = love.audio.newSource('assets/sounds/music3.mp3', 'static'),
    ['next-level'] = love.audio.newSource('assets/sounds/next-level.wav', 'static'),
    ['select'] = love.audio.newSource('assets/sounds/select.wav', 'static'),
}

-- FONT
game_Fonts = {
    ['smallFont'] = love.graphics.newFont('assets/fonts/font.ttf', 8),
    ['mediumFont'] = love.graphics.newFont('assets/fonts/font.ttf', 16),
    ['largeFont'] = love.graphics.newFont('assets/fonts/font.ttf', 24),
    ['hugeFont'] = love.graphics.newFont('assets/fonts/font.ttf', 32),
}

-- TEXTURE
game_Textures = {
    ['background'] = love.graphics.newImage('assets/graphics/background.png'),
    ['main'] = love.graphics.newImage('assets/graphics/match3.png')
}


-- BACKGROUND LOOPING POINT
BACKGROUND_LOOPING_POINT = 1024/2;
BACKGROUND_SCROLLING_SPEED = 30;

-- TILE DIMENSIONS
TILE_WIDTH = 32;
TILE_HEIGHT = 32;


-- GAME FRAMES
game_Frames = {
    ['tiles'] = generateQuad(game_Textures['main'], TILE_WIDTH, TILE_HEIGHT)
}