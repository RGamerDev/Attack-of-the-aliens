-- Pass Object as first argument.
Enemy = Object.extend(Object)

ENEMY_TYPES = {
    [1] = 'Beige',
    [2] = 'Blue',
    [3] = 'Green',
    [4] = 'Pink',
    [5] = 'Yellow'
}

function Enemy:new(type, x, y, key)

    -- type of enemy selected
    self.type = type 

    -- enemy image
    self.sprite = love.graphics.newImage('Graphics/alien-ufo-pack/PNG/ship'..ENEMY_TYPES[self.type]..'_manned.png')

    -- enemy dimensions
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()

    -- enemy center coordinates
    self.x = x
    self.y = y

    self.r = 0

    self.xo = self.width / 2
    self.yo = self.height / 2
    
    -- setting boundaries for floating enemies
    self.leftBorder = self.x - self.width / 2
    self.rightBorder = self.x + self.width / 2
    
    self.dx = math.random(-50, 50)
    
    -- enemy's missiles
    self.missile = Missile(self.x, self.y, self.dx, self.dy, math.rad(180))
    self.missile.dead = true
    
    -- isdead value
    self.dead = false

    -- unique identifier
    self.key = key

    self.timer = math.random(15)
end

function Enemy:update(dt, player)

    -- counting down timer
    self.timer = self.timer - dt

    -- checking if enemy hit the left or right boundary
    if self.x <= self.leftBorder or self.x >= self.rightBorder then
        self.dx = -self.dx
    end

    -- updating enemy's floating velocity
    self.x = self.x + self.dx * dt

    -- updating self.missiles movement
    if self.missile.dead == false then
        self.missile:update(dt)
    else
        self.missile:setX(self.x + self.width / 2)
        self.missile:setY(self.y + self.height)
    end

    -- checking missile collision
    for _, missile in ipairs(player.missiles) do
        if missile:checkCol(self) then
            self.dead = true
        end
    end

    -- checking shooting interval
    if self.timer <= 0 then
        self:shoot()
        self.timer = math.random(15)
    end
end

function Enemy:draw()
    -- drawing Enemy
    love.graphics.draw(self.sprite, self.x, self.y, self.r, 1, 1, self.xo, self.yo) 

    -- debug
    love.graphics.rectangle('line', self.x - self.xo, self.y - self.yo, self.width, self.height) 
    -- love.graphics.print(math.floor(self.timer), self.x, self.y + self.height) 
    -- love.graphics.print(self.missile.dead and 'dead' or 'alive', self.x + self.width, self.y + self.height) 

    -- drawing missiles
    if self.missile.dead == false then
        self.missile:draw()
    end
end

function Enemy:hit()
    self.dead = true
end

function Enemy:shoot()
    self.missile.dead = false
end