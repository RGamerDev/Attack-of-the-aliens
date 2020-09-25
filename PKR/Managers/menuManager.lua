menuManager = Object.extend(Object)

-- suit up
local suit = require './Libraries/suit'

local instance = 'main'

function menuManager:new()
    GUI = 
    {
        ['main'] = suit.new(),
        ['controls'] = suit.new(),
        ['multiplayer'] = suit.new()
    }

    size = 100
end

function menuManager:update(dt)

    GUI[instance].layout:reset(0, 0)

    GUI[instance]:Label('Attack of the aliens!', {align = 'center', valign = 'center'}, GUI[instance].layout:row(WINDOW_WIDTH, 100))

    if instance == 'main' then
        -- Put a button on the screen. If hit, show a message.
        if GUI[instance]:Button("Normal mode", GUI[instance].layout:row(WINDOW_WIDTH, UISize)).hit then
            loadMode('normal')
        elseif GUI[instance]:Button("Classic mode", GUI[instance].layout:row(WINDOW_WIDTH, UISize)).hit then
            loadMode('classic')
        elseif GUI[instance]:Button("Controls", GUI[instance].layout:row(WINDOW_WIDTH, UISize)).hit then
            instance = 'controls'
        elseif GUI[instance]:Button("Exit", GUI[instance].layout:row(WINDOW_WIDTH, UISize)).hit then
            love.event.quit()
        end

    elseif instance == 'controls' then
        GUI[instance]:Label('Controls', {align = 'center', valign = 'center'}, GUI[instance].layout:row(WINDOW_WIDTH, 100))
        GUI[instance]:Label('a\tmove left', {align = 'center', valign = 'center'}, GUI[instance].layout:row(WINDOW_WIDTH, 100))
        GUI[instance]:Label('d\tmove right', {align = 'center', valign = 'center'}, GUI[instance].layout:row(WINDOW_WIDTH, 100))
        GUI[instance]:Label('space\tshoot missile', {align = 'center', valign = 'center'}, GUI[instance].layout:row(WINDOW_WIDTH, 100))
        
        if GUI[instance]:Button("Back", GUI[instance].layout:row(WINDOW_WIDTH, UISize)).hit then
            instance = 'main'
        end
    end

end

function menuManager:draw()
    GUI[instance]:draw()
end

function menuManager:mouseReleased(x, y)
    
end