ManagerUtil = Object.extend(Object)

function ManagerUtil:new()
    self.x = 150
    self.y = 100
end

function ManagerUtil:chkMovement(player, negative, positive, dt)

    if Mode == 'normal' or Mode == 'classic' or Mode == 'online' then
        if love.keyboard.isDown(negative) then
            player.dx = player.flyingSpeed
            player.flyingSpeed = player.flyingSpeed - 400 * dt
        elseif love.keyboard.isDown(positive) then
            player.dx = player.flyingSpeed
            player.flyingSpeed = player.flyingSpeed + 400 * dt
        else
            player.dy = 0
            player.dx = player.dx > 0 and player.dx - 1 or player.dx + 1
            player.flyingSpeed = 0
        end

    elseif Mode == 'offline' then
        if love.keyboard.isDown(negative) then
            player.dy = player.flyingSpeed
            player.flyingSpeed = player.flyingSpeed - 400 * dt
        elseif love.keyboard.isDown(positive) then
            player.dy = player.flyingSpeed
            player.flyingSpeed = player.flyingSpeed + 400 * dt
        else
            player.dx = 0
            player.dy = player.dy > 0 and player.dy - 1 or player.dy + 1
            player.flyingSpeed = 0
        end
        
    end
end

function ManagerUtil:generateEnemies(count)

    enemies = {}

    if count >= 1 and count <= 24 then

        for i = 1, count do

            current_enemy = Enemy(math.random(5), self.x, self.y, i)

            self.x = self.x + current_enemy.width + WINDOW_WIDTH / 25
            if i % 9 == 0 then
                self.x = 150
                self.y = self.y + current_enemy.height +  50
            end

            count = count - 1

            enemies[i] = current_enemy
        end
    end

    return enemies
end