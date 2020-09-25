Player = Object.extend(Object)

SHOOTING_INTERVAL = 2
HIT_INTERVAL = 1
LIVES = 1

function Player:new(x, y)

    self.name = 'Player'

    -- Loading sprite image
    self.texture = love.graphics.newImage('Graphics/kenney_spaceshooterextension/PNG/Sprites/Ships/spaceShips_009.png')

    -- sprite dimensions
    self.width = self.texture:getWidth()
    self.height = self.texture:getHeight()

    -- top left coordinates
    self.x = x
    self.y = y

    -- center offset
    self.xo = self.width / 2
    self.yo = self.height / 2

    -- x and y velocity
    self.dx = 0
    self.dy = 0

    self.lives = LIVES
    self.dead = false

    self.missiles = {}

    -- Loading sounds
    self.sounds = {
        ['shoot'] = love.audio.newSource('Audio/Laser_Shoot.wav', 'static'),
        ['explode'] = love.audio.newSource('Audio/Explosion.wav', 'static'),
        ['hit'] = love.audio.newSource('Audio/Laser_Shoot.wav', 'static')
    }

    -- time intervals
    self.shoot_timer = 0
    self.hit_timer = 0

    self.flyingSpeed = 0

end

-- Updating the player
function Player:update(dt, entities)

    if self.dead == false then
        -- counting down shoot_timer
        self.shoot_timer = self.shoot_timer - dt
        self.hit_timer = self.hit_timer - dt

        -- missile location
        self.mx = self.x + self.xo
        self.my = self.y - self.yo

        self:chkBnds()

        -- updating the player's missiles
        for key, missile in ipairs(self.missiles) do
            if missile.dead == false then
                missile:update(dt)
            else
                self:removeMissile(key)
            end
        end

        -- checking missile collision
        for _, entity in ipairs(entities) do
            if mngUtil:checkCol(self, entity.missile) then
                self:hit()
            end
        end

        self:move(dt)
    end
end

-- drawing the player
function Player:draw()

    if self.dead == false then
        -- drawing Player
        love.graphics.draw(self.texture, self.x, self.y, 0, 1, 1, self.xy, self.yo)

        -- debug
        love.graphics.rectangle('line', self.x, self.y - self.yo, self.width, self.height)

        -- drawing all of the player's missiles
        for _, missile in ipairs(self.missiles) do
            missile:draw()
        end
    end
end

-- shooting a missile
function Player:shoot()

if self.shoot_timer <= 0 and self.dead == false then
    self:play('shoot')

    key = #self.missiles + 1
    self.missiles[key] = Missile(self.name, self.mx, self.my, self.dx, self.dy, self.r)
    self.shoot_timer = SHOOTING_INTERVAL
end

end

-- removing a missile
function Player:removeMissile(key)
    table.remove(self.missiles, key)
end

-- playing sounds
function Player:play(sound)
    self.sounds[sound]:play()
end

-- taking damage
function Player:hit()

    if self.hit_timer <= 0 then
        if self.lives == 1 then
            self.dead = true
        else
            self.lives = self.lives - 1
        end
        self.hit_timer = HIT_INTERVAL
    end
end

-- moving player
function Player:move(dt)

    if love.keyboard.isDown('a') then
        player.dx = player.flyingSpeed
        player.flyingSpeed = player.flyingSpeed - 400 * dt
    elseif love.keyboard.isDown('d') then
        player.dx = player.flyingSpeed
        player.flyingSpeed = player.flyingSpeed + 400 * dt
    else
        player.dy = 0
        player.dx = player.dx > 0 and player.dx - 1 or player.dx + 1
        player.flyingSpeed = 0
    end    

    self.x = self.x + self.dx * dt
end

-- checking window boundaries
function Player:chkBnds()
    -- left and right boundaries checking
    if self.x - self.xo < 0 then
        self.x = 0 + self.xo
        self.flyingSpeed = 0
    elseif self.x + self.xo > WINDOW_WIDTH then
        self.x = WINDOW_WIDTH - self.xo
        self.flyingSpeed = 0
    end
end
