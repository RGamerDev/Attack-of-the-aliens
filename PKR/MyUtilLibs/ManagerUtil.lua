ManagerUtil = Object.extend(Object)

function ManagerUtil:new()
    self.x = 150
    self.y = 100

    -- Loading sounds
    self.sounds = {
        ['shoot'] = love.audio.newSource('Audio/Laser_Shoot.wav', 'static'),
        ['explode'] = love.audio.newSource('Audio/Explosion.wav', 'static'),
        ['hit'] = love.audio.newSource('Audio/Hit_Hurt.wav', 'static'),
        ['victory'] = love.audio.newSource('Audio/Victory.wav', 'static'),
        ['defeat'] = love.audio.newSource('Audio/Defeat.wav', 'static'),
        ['click'] = love.audio.newSource('Audio/Click.wav', 'static')
    }
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

function ManagerUtil:kill_enemy(key)
    table.remove(enemies, key)
end

-- checking missile missile collision with another object(obj)
function ManagerUtil:checkCol(a, b)

    --With locals it's common usage to use underscores instead of camelCasing

    local a_left = a.x - a.xo
    local a_right = a.x + a.xo
    local a_top = a.y - a.yo
    local a_bottom = a.y + a.yo

    local b_left = b.x - a.xo
    local b_right = b.x + a.xo
    local b_top = b.y - a.yo
    local b_bottom = b.y + a.yo

    --If Red's right side is further to the right than Blue's left side.
    if a_right > b_left and
    --and Red's left side is further to the left than Blue's right side.
    a_left < b_right and
    --and Red's bottom side is further to the bottom than Blue's top side.
    a_bottom > b_top and
    --and Red's top side is further to the top than Blue's bottom side then..
    a_top < b_bottom then
        --There is collision!
        return true
    else
        --If one of these statements is false, return false.
        return false
    end

end

-- playing sounds
function ManagerUtil:play(sound)
    self.sounds[sound]:play()
end