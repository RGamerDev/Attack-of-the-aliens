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

    UIHeight = 100
    UIWidth = WINDOW_WIDTH * 0.5
end

function menuManager:update(dt)

    GUI[instance].layout:reset(WINDOW_WIDTH * 0.25, WINDOW_HEIGHT * 0.25)

    GUI[instance]:Label('Attack of the aliens!', {align = 'center', valign = 'center'}, GUI[instance].layout:row(UIWidth, 200))

    if instance == 'main' then
        -- Put a button on the screen. If hit, show a message.
        if GUI[instance]:Button("Normal mode", GUI[instance].layout:row(UIWidth, UIHeight)).hit then
            mngUtil:play('click')
            loadMode('normal')
        elseif GUI[instance]:Button("Classic mode", GUI[instance].layout:row(UIWidth, UIHeight)).hit then
            mngUtil:play('click')
            loadMode('classic')
        elseif GUI[instance]:Button("Controls", GUI[instance].layout:row(UIWidth, UIHeight)).hit then
            mngUtil:play('click')
            instance = 'controls'
        elseif GUI[instance]:Button("Exit", GUI[instance].layout:row(UIWidth, UIHeight)).hit then
            mngUtil:play('click')
            love.event.quit()
        end

    elseif instance == 'controls' then
        GUI[instance]:Label('Controls', {align = 'center', valign = 'center'}, GUI[instance].layout:row(UIWidth, UIHeight))
        GUI[instance]:Label('a\tmove left', {align = 'left', valign = 'center'}, GUI[instance].layout:row(UIWidth, UIHeight)),
        GUI[instance]:Label('d\tmove right', {align = 'left', valign = 'center'}, GUI[instance].layout:row(UIWidth, UIHeight))
        GUI[instance]:Label('space\tshoot missile', {align = 'left', valign = 'center'}, GUI[instance].layout:row(UIWidth, UIHeight))
        
        if GUI[instance]:Button("Back", GUI[instance].layout:row(UIWidth, UIHeight)).hit then
            mngUtil:play('click')
            instance = 'main'
        end
    end

end

function menuManager:draw()
    GUI[instance]:draw()
end

function menuManager:mouseReleased(x, y)
    
end