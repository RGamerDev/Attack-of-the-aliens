onlineManager = Object.extend(Object)

require 'Entities/player'
require 'Entities/enemy'
require 'Entities/missile'

function onlineManager:new()

    -- setting background
    bg = love.graphics.newImage('Graphics/stars_milky_way_space_116893_1920x1080.jpg')

    -- loading player
    player = Player(WINDOW_WIDTH * 0.5, WINDOW_HEIGHT * 0.9, 0)

end

function onlineManager:update(dt)

    if player.dead == false then

        mngUtil:chkMovement(player, 'a', 'd', dt)

        player:move('x', dt)

        -- updating player
        player:update(dt)

    else
        loadMode('status', 'You lose!')
    end

end

function onlineManager:draw()

    love.graphics.draw(bg)

    if player.dead == false then
        -- Drawing player
        player:draw()
    
        -- debug
        -- love.graphics.print('enemies: ' .. #enemies, 25, 50)
        -- love.graphics.print('player lives:'..self.lives, 25, 100) 

    elseif player.dead == true then
        loadMode('status', 'You Lose!')
        
    elseif #enemies <= 0 then
        loadMode('status', 'You Win!')
    end
end

function onlineManager:keypressed(key)
    if key == 'space' then
        player:shoot()
    end
end