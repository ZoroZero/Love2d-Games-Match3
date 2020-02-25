BeginGameState = Class{__includes = BaseState}

-- ENTER FUNCTION
function BeginGameState:enter( params )
    self.level = params.level;

    self.transition_opacity = 1;

    Timer.tween(1, {
        [self] = {transition_opacity= 0}
    }):finish(function()
    end
    )
end


-- UPDATE FUNCTION
function BeginGameState:update( dt )
    Timer.update(dt);
end

-- RENDER FUNCTION
function BeginGameState:render()
     -- DRAW TRANSITION SCREEN
    love.graphics.setColor(1, 1, 1, self.transition_opacity);
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end