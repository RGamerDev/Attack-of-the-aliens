levelManager = Object.extend(Object)

require 'Entities/player'
require 'Entities/enemy'
require 'Entities/missile'

function levelManager:new()

    -- setting background
    bg = love.graphics.newImage('Graphics/stars_milky_way_space_116893_1920x1080.jpg')

    -- loading player
    player = Player(WINDOW_WIDTH * 0.5, WINDOW_HEIGHT * 0.9, 0)

    -- loading enemies
    enemies = mngUtil:generateEnemies(24)
end

function levelManager:update(dt)

    if player.dead == false then

        mngUtil:chkMovement(player, 'a', 'd', dt)

        player:move('x', dt)

        -- updating player
        player:update(dt, enemies)

    
        -- updating enemies and checking if they are dead
        for key, enemy in ipairs(enemies) do
            if enemy.dead == false then
                enemy:update(dt, player)
            else
                levelManager:kill_enemy(key)
            end
        end
    end
end

function levelManager:draw()

    love.graphics.draw(bg)

    if #enemies > 0 and player.dead == false then
        
    
        -- Drawing player
        player:draw()
    
        -- Drawing enemies
        for _, enemy in ipairs(enemies) do
            enemy:draw()
        end
    
        -- debug
        love.graphics.print('enemies: ' .. #enemies, 25, 50)
        -- love.graphics.print('player lives:'..self.lives, 25, 100) 

    elseif player.dead == true then
        loadMode('status', 'You Lose!')
        
    elseif #enemies <= 0 then
        loadMode('status', 'You Win!')
    end
end

function levelManager:kill_enemy(key)
    table.remove(enemies, key)
end

function levelManager:keypressed(key)
    if key == 'space' then
        player:shoot()
    end
end