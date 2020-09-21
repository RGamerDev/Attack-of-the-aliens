classicManager = Object.extend(Object)

TIMER = 5

require 'Entities.player'
require 'Entities.enemy'
require 'Entities.missile'

function classicManager:new()
    -- setting background
    bg = love.graphics.newImage('Graphics/stars_milky_way_space_116893_1920x1080.jpg')

    -- loading player
    player = Player(WINDOW_WIDTH * 0.5, WINDOW_HEIGHT * 0.9, 0)

    -- loading enemies
    enemies = mngUtil:generateEnemies(24)

    self.shiftTimer = TIMER

end

function classicManager:update(dt)
    
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
                self:kill_enemy(key)
            end
        end

        if self.shiftTimer <= 0 then
            self.shiftEnemies()
            self.shiftTimer = TIMER
        else
            self.shiftTimer = self.shiftTimer - dt
        end
    end
end

function classicManager:draw()
    love.graphics.draw(bg)

    if #enemies > 0 and player.dead == false then
        
    
        -- Drawing player
        player:draw()
    
        -- Drawing enemies
        for _, enemy in ipairs(enemies) do
            enemy:draw()
        end
    
        -- debug
        love.graphics.print('enemies: ' .. #enemies, 300, 25)
        love.graphics.print('Timer: ' .. self.shiftTimer, WINDOW_WIDTH * .5, 25)
        -- love.graphics.print('player lives:'..self.lives, 25, 100) 

    elseif player.dead == true then
        loadMode('status', 'You Lose!')
        
    elseif #enemies <= 0 then
        loadMode('status', 'You Win!')
    end
end

function classicManager:kill_enemy(key)
    table.remove(enemies, key)
end

function classicManager:keypressed(key)
    if key == 'space' then
        player:shoot()
    end
end

function classicManager:shiftEnemies()
    for i = 1, #enemies do
        enemies[i].y = enemies[i].y + 50
    end
end