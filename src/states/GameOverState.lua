GameOverState = Class {__includes = BaseState}

-- enter function
function GameOverState:enter(params)
    self.score = params.score;

    game_Sounds['music3']:play();
    game_Sounds['music3']:setLooping(true);
end

-- UPDATE FUNCTION
function GameOverState:update(dt)
    if love.keyboard.wasPressed('escape') then 
        love.event.quit();
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        game_Sounds['confirm']:play();
        game_Sounds['music3']:stop()
        game_State_Machine:change('start');
    end
end

-- RENDER
function GameOverState:render()
    -- DRAW END TABLE
    love.graphics.setColor(56/255, 56/255,56/255, 0.9)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2 - 100, VIRTUAL_HEIGHT/2 - 60, 200, 120);

    -- DRAW GUI TEXT
    love.graphics.setColor(56/255, 155/255, 1, 1);
    love.graphics.setFont(game_Fonts['mediumFont']);
    love.graphics.printf("YOU LOST !", VIRTUAL_WIDTH/2 - 100, VIRTUAL_HEIGHT/2 - 50, 200, 'center');
    love.graphics.printf("Score: " .. tostring(self.score), VIRTUAL_WIDTH/2 - 100, VIRTUAL_HEIGHT/2 - 24, 200, 'center');
    love.graphics.printf("Press Enter to play again", VIRTUAL_WIDTH/2 - 100, VIRTUAL_HEIGHT/2 + 8, 200, 'center');
end