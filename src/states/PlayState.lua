PlayState = Class {__includes = BaseState}

-- ENTER FUNCTION
function PlayState:enter(params)
    self.level = params.level;
    self.board = params.board;
end

-- UPDATE FUNCTION
function PlayState:update(dt)
    Timer.update(dt);

end


-- RENDER FUNCTION
function PlayState:render()
    self.board:render();
end