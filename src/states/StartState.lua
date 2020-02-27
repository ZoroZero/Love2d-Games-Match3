StartState = Class{__includes = BaseState}

local positions = {}
-- Variable to keep track which option user choose
local highlighted_Option = 1;

-- Board x, y
local board_X =  VIRTUAL_WIDTH/2 - TILE_WIDTH*4;
local board_Y = VIRTUAL_HEIGHT/2 - TILE_HEIGHT*4;

function StartState:init( )
    self.colors = {
        [1] = {217/255, 87/255, 99/255, 255},
        [2] = {95/255, 205/255, 228/255, 255},
        [3] = {251/255, 242/255, 54/255, 255},
        [4] = {118/255, 66/255, 138/255, 255},
        [5] = {153/255, 229/255, 80/255, 255},
        [6] = {223/255, 113/255, 38/255, 255}
    }

    self.letter_Table = {
        {'M', -108},
        {'A', -64},
        {'T', -28},
        {'C', 2},
        {'H', 40},
        {'0', 112}
    }

    self.color_Timer = Timer.every(0.075, function()
        self.colors[0] = self.colors[6];

        for i = 6, 1, -1 do 
            self.colors[i] = self.colors[i-1];
        end
    end
    );

    -- Variable to keep the change of screen, when go to begin state -> 255
    self.transition_opacity = 0;

    -- check if we are in transition
    self.is_Pause = false;

    for i = 1, 64 do
        table.insert( positions, game_Frames['tiles'][math.random( 1, 18)][math.random(1,6)])
    end
end



-- UPDATE FUNCTION
function StartState:update(dt)
    if not self.is_Pause then    
        
        -- CHECK CHANGE OPTIONS
        if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
            highlighted_Option = highlighted_Option == 1 and 2 or 1;
            game_Sounds['select']:play();
        end

        -- IF PRESSED ENTER CHECK
        if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
            game_Sounds['confirm']:play()

            -- QUIT IF OPTION = 2
            if highlighted_Option == 2 then
                love.event.quit();
            else
                -- TRANSITION SCREEN
                Timer.tween(1, {
                    [self] = {transition_opacity = 1}}
                ):finish(function() 
                            game_State_Machine:change('begin_game', {
                                level = 1,
                                score = 0,
                            });
                            self.color_Timer:remove();
                        end
                )   
            end

            self.is_Pause = true;
        end

        -- if love.mouse.wasPressed(1) then 
        --     Timer.tween(1, {
        --         [self] = {transition_opacity = 1}}
        --     ):finish(function() 
        --                 game_State_Machine:change('begin_game', {
        --                     level = 1,
        --                     score = 0,
        --                 });
        --                 self.color_Timer:remove();
        --             end
        --     )   
        --     self.is_Pause = true;
        -- end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit();
    end 
        
    -- Update timer
    Timer.update(dt);
end


-- Render function
function StartState:render()
    -- Draw board
    for y = 1,8 do
       
        for x = 1, 8 do 
            -- Draw shadow
            love.graphics.setColor(0,0,0,255);
            love.graphics.draw(game_Textures['main'], positions[x + (y - 1) * 8], 
            board_X + (x - 1)* TILE_WIDTH  + 3, board_Y + (y-1) * TILE_HEIGHT + 3);

            -- Draw tiles
            love.graphics.setColor(255,255,255,255);
            love.graphics.draw(game_Textures['main'], positions[x + (y - 1) * 8], 
            board_X + (x - 1)* TILE_WIDTH, board_Y + (y - 1) * TILE_HEIGHT);
        end
    end

    --  Draw rectangle to shadow the background
    love.graphics.setColor(0, 0, 0, 1/2)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    -- Draw TITLE PART
    self:drawTitle(VIRTUAL_HEIGHT/2 - 73);

    -- DRAW MENU OPTIONS
    self:drawMenuOption(VIRTUAL_HEIGHT/2 + 15);

    -- DRAW TRANSITION SCREEN
    love.graphics.setColor(1, 1, 1, self.transition_opacity);
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end

-- DRAW TITLE
function StartState:drawTitle(y)
    love.graphics.setColor(1, 1, 1, 1/2)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2 - 80, y, 160, 58, 6)

    love.graphics.setFont(game_Fonts['hugeFont']);
    drawShadowText("MATCH 0", y + 13);

    for i = 1, 6 do
        love.graphics.setColor(self.colors[i])
        love.graphics.printf(self.letter_Table[i][1], 0, y + 13,
            VIRTUAL_WIDTH + self.letter_Table[i][2], 'center')
    end
end

-- DRAW MENU PART 
function StartState:drawMenuOption(y)
    love.graphics.setFont(game_Fonts['mediumFont']);
    love.graphics.setColor(1, 1, 1, 1/2)
    -- RECTANGLE CONTAIN OPTIONS
    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2 - 80, y, 160, 58, 6)

    -- START OPTION
    drawShadowText("Start", y + 8);
    if highlighted_Option == 1 then 
        love.graphics.setColor(99/255, 155/255, 1, 255);
    else
        love.graphics.setColor(215/255, 123/255, 186/255, 255);
    end
    love.graphics.printf("Start", 0, y + 8, VIRTUAL_WIDTH, 'center');

    -- QUIT GAME OPTION
    drawShadowText("Quit game", y + 31);
    if highlighted_Option == 2 then 
        love.graphics.setColor(99/255, 155/255, 1, 255);
    else
        love.graphics.setColor(215/255, 123/255, 186/255, 255);
    end
    love.graphics.printf("Quit game", 0, y + 31, VIRTUAL_WIDTH, 'center');
end

-- HELP TO DRAW SHADOW TEXT FUNCTION
function drawShadowText(text, y)
    love.graphics.setColor(0, 0, 0, 255);
    love.graphics.printf(text, 2, y + 1, VIRTUAL_WIDTH, 'center');
    love.graphics.printf(text, 1, y + 1, VIRTUAL_WIDTH, 'center');
    love.graphics.printf(text, 0, y + 1, VIRTUAL_WIDTH, 'center');
    love.graphics.printf(text, 1, y + 2, VIRTUAL_WIDTH, 'center');
end