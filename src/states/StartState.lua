StartState = Class{__includes = BaseState}

local positions = {}
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
        {'3', 112}
    }

    self.color_Timer = Timer.every(0.075, function()
        self.colors[1] = self.colors[6];

        for i = 6, 2, -1 do 
            self.colors[i] = self.colors[i-1];
        end
    end
    );


end


-- UPDATE FUNCTION
function StartState:update(dt)
    Timer.update(dt);
end


-- Render function
function StartState:render()

    love.graphics.setFont(game_Fonts['mediumFont']);

    for i = 1, 6 do
        love.graphics.setColor(self.colors[i])
        love.graphics.printf(self.letter_Table[i][1], 0, VIRTUAL_HEIGHT / 2 + 10,
            VIRTUAL_WIDTH + self.letter_Table[i][2], 'center')
    end
end

