-- Pass Object as first argument.
Missile = Object.extend(Object)

function Missile:new(name, x, y, dx, dy, r)

    self.name = 'Missile'

    -- Sprite texture
    self.texture = love.graphics.newImage('Graphics/kenney_spaceshooterextension/PNG/Sprites X2/Missiles/spaceMissiles_001.png')

    self.width = self.texture:getWidth()
    self.height = self.texture:getHeight()
    
    -- Missile rotation in radians
    self.r = r

    self.owner = name

    -- missile horizontal and vertical velocity
    self.dx = dx
    self.dy = name == 'Player' and -250 or 250

    -- centerpoint of Missile
    self.x = x
    self.y = y
    self.xo = self.width / 2
    self.yo = self.height / 2
    
    -- collided with something (destroyed)
    self.dead = false
end

-- updating missile's state
function Missile:update(dt)

    if not self.dead then
        self:chkBnd()

        -- changing missile y velocity
        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt
    end
end

-- drawing the missile
function Missile:draw()

    -- drawing the Missile 
    love.graphics.draw(self.texture, self.x, self.y, self.r, 1, 1, self.xo, self.yo)

    -- debugging x and y and collider
    -- love.graphics.rectangle('line', self.x - self.xo, self.y - self.yo, self.width, self.height)   

    -- love.graphics.line( self.x - self.xo, self.y - self.yo,
    --                         self.x + self.xo, self.y - self.yo,
    --                         self.x + self.xo, self.y + self.yo,
    --                         self.x - self.xo, self.y + self.yo,
    --                         self.x - self.xo, self.y - self.yo)

end

function Missile:chkBnd()

    -- -- checking if missile reached the boundary
    if self.y <= 0 or self.y >= WINDOW_HEIGHT then
        self.dead = true
        return
    elseif self.x <= 0 or self.x >= WINDOW_WIDTH then
        self.dead = true
        return
    end
end