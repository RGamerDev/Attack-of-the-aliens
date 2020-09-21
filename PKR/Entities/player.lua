Player = Object.extend(Object)

SHOOTING_INTERVAL = 2
HIT_INTERVAL = 3
LIVES = 1

function Player:new(x, y, r)

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

    -- angle
    self.r = math.rad(r)
    self.sin = math.sin(math.deg(self.r))
    self.cos = math.cos(math.deg(self.r))

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
        self.mx = self.x
        self.my = self.y

        self:chkBnds()

        -- updating the player's missiles
        for key, missile in ipairs(self.missiles) do
            if missile.dead == false then
                missile:update(dt)
            else
                self:removeMissile(key)
            end
        end

        if entities ~= nil then
            
            if Mode == 'normal' or Mode == 'classic' then
                -- checking missile collision
                for _, entity in ipairs(entities) do
                    if entity.missile:checkCol(self) then
                        self:hit()
                    end
                end
            elseif Mode == 'offline' or Mode == 'online' then
                
                for _, missile in ipairs(entities.missiles) do
                    if missile:checkCol(self) then
                        self:hit()
                    end
                end
                
            end
        end
    end
end

-- drawing the player
function Player:draw()

    if self.dead == false then
        -- drawing Player
        love.graphics.draw(self.texture, self.x, self.y, self.r, 1, 1, self.xo, self.yo)

        -- debug
        -- love.graphics.rectangle('line', self.x - self.xo, self.y - self.yo, self.width, self.height)
        -- love.graphics.print('player missiles:'..#self.missiles, 25, 75)
        -- love.graphics.print('player x: ' .. self.x, self.x + self.xo, self.y)
        -- love.graphics.print('player y: ' .. self.y, self.x + self.xo, self.y + 15)
        -- love.graphics.print('player width: ' .. self.width, 25, 175)
        -- love.graphics.print('player height: ' .. self.height, 25, 200)
        -- love.graphics.print('player x velocity: ' .. self.dx, 0, 0)
        -- love.graphics.print('player y velocity: ' .. self.dy, 0, 15)

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
    self.missiles[key] = Missile(self.mx, self.my, self.dx, self.dy, self.r)
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
function Player:move(axis, dt)
    if axis == 'x' then
        self.x = self.x + self.dx * dt
    elseif axis == 'y' then
        self.y = self.y + self.dy * dt
    end
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

    -- up and down boundaries checking
    if self.y - self.xo < 0 then
        self.y = 0 + self.xo
        self.flyingSpeed = 0
    elseif self.y + self.xo > WINDOW_HEIGHT then
        self.y = WINDOW_HEIGHT - self.xo
        self.flyingSpeed = 0
    end
    

end
