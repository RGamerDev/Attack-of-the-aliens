Status = Object.extend(Object)

function Status:new(status)
    self.status = status == nil and 'lose/win' or status
    
    love.graphics.setFont(Roboto)

    self.timer = 3.5
end

-- for updating the state
function Status:update(dt)
    if self.timer <= 0 then
        love.load()
    end

    self.timer = self.timer - dt
end

function Status:draw()
    love.graphics.print(self.status,
    WINDOW_WIDTH / 2 - Roboto:getWidth(self.status) / 2,
    WINDOW_HEIGHT / 2 - Roboto:getHeight() / 2)

    -- love.graphics.print(self.timer, 0, 100)
end