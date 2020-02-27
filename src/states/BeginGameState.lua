BeginGameState = Class{__includes = BaseState}

-- INIT FUNCTION
function BeginGameState:init()
    self.board = Board(VIRTUAL_WIDTH - 272, 16);

    self.levelLabel_y = -64;

    self.transition_opacity = 1;
end

-- ENTER FUNCTION
function BeginGameState:enter( params )
    -- Initialize all enter params
    self.level = params.level;
    self.score = params.score;

    -- TRANSITION BACK TO NORMAL
    Timer.tween(1, {
        [self] = {transition_opacity= 0}
    })
    -- AFTER MOVE LEVEL LABEL TO MIDDLE OF THE SCREEN
    :finish(function()
        Timer.tween(1, {
            [self] = {levelLabel_y = VIRTUAL_HEIGHT/2 -8} 
        })
        -- AFTER MOVE LEVEL LABEL OUT OF SCREEN
            :finish(function()
                Timer.after(1, function() 
                            Timer.tween(0.5, {
                                [self] = {levelLabel_y = VIRTUAL_HEIGHT + 10}
                            })
                            -- AFTER CHANGE TO PLAY STATE
                                :finish(function()
                                    game_State_Machine:change('play', {
                                        level = self.level,
                                        board = self.board,
                                        score = self.score,
                                        timer = 60,
                                    })
                                    end)
                                end)
                    end)
            end)
end


-- UPDATE FUNCTION
function BeginGameState:update( dt )
    Timer.update(dt);
end

-- RENDER FUNCTION
function BeginGameState:render()
    -- DRAW BOARD
    self.board:render(); 

    -- DRAW LEVEL LABEL
    love.graphics.setFont(game_Fonts['hugeFont']);
    love.graphics.setColor( 95/255, 155/255, 255/255, 4/5);
    love.graphics.rectangle('fill', 0, self.levelLabel_y, VIRTUAL_WIDTH, 35);

    love.graphics.setColor(1,1,1,1);
    love.graphics.printf("Level " .. tostring(self.level), 0, self.levelLabel_y + 5, VIRTUAL_WIDTH, 'center')

    -- DRAW TRANSITION SCREEN
    love.graphics.setColor(1, 1, 1, self.transition_opacity);
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT);
end