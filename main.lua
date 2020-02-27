require 'src/Dependencies';

-- LOAD FUNCTION
function love.load()
    -- Stress test
    birdSprite = love.graphics.newImage('assets/graphics/bird.png');

    -- SET TEXTURE RENDER
    love.graphics.setDefaultFilter('nearest', 'nearest');

    -- SET TITLE
    love.window.setTitle("Match me");

    -- SET RANDOMSEED
    math.randomseed(os.time());

    -- SET WINDOWS SCREEN
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        fullscreen = false,
        vsyn = true
    })


    -- SETUP GAME STATE MACHINE
    game_State_Machine = StateMachine{
        ['start'] = function() return StartState() end,
        ['begin_game'] = function() return BeginGameState() end,
        ['play'] = function () return PlayState() end,
        ['game_over'] = function () return GameOverState() end
    };

    game_State_Machine:change('start');


    -- SET UP KEY CHECK
    love.keyboard.keysPressed = {};

    -- SET UP BACKGROUND x
    background_x = 0;
end


-- UPDATE FUNCTION
function love.update(dt)
    -- UPDATE BACKGROUND
    background_x = (background_x + BACKGROUND_SCROLLING_SPEED*dt) % BACKGROUND_LOOPING_POINT; 

    game_State_Machine:update(dt);

    love.keyboard.keysPressed = {};
end


-- RENDER FUNCTION
function love.draw()
    push:start()

    -- draw background
    love.graphics.draw(game_Textures['background'], -background_x, 0);

    -- render state
    game_State_Machine:render();

    displayFPS()

    push:finish()
end


-- RESIZE SCREEN FUNCTION
function love.resize(w, h)
    push:resize(w,h);
end


-- KEY PRESSED FUNCTION
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true;
end


-- CHECK KEY WAS PRESSED FUNCTION
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key];
end

-- DISPLAY FPS FUNCTION
function displayFPS()
    love.graphics.setFont(game_Fonts['smallFont']);
    love.graphics.setColor(255, 255, 0, 255);
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10);
end