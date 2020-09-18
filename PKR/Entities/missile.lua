-- Pass Object as first argument.
Missile = Object.extend(Object)

function Missile:new(x, y, dx, dy, r)

    -- Sprite texture
    self.texture = love.graphics.newImage('Graphics/kenney_spaceshooterextension/PNG/Sprites X2/Missiles/spaceMissiles_001.png')

    self.width = self.texture:getWidth()
    self.height = self.texture:getHeight()
    
    -- Missile rotation in radians
    self.r = r

    if Mode ~= 'offline' then
        -- entity check
        self.isPlayer = y > WINDOW_HEIGHT * 0.6 and true or false

        -- missile horizontal and vertical velocity
        self.dx = dx
        self.dy = self.isPlayer and -250 or 250
    else
        self.dx = 250 * math.sin(self.r)
        self.dy = dy
    end

    -- centerpoint of Missile
    self.x = x
    self.y = y
    self.xo = self.width / 2
    self.yo = self.height / 2
    
    

    self.left = self.isPlayer and self.x or self.x - self.width
    self.right = self.isPlayer and self.x + self.width or self.x
    self.top = self.isPlayer and self.y or self.y - self.height
    self.bottom = self.isPlayer and self.y + self.height or self.y

    -- collided with something (destroyed)
    self.dead = false
end

function Missile:setX(x)
     self.x = x
end

function Missile:setY(y)
    self.y = y
end

-- updating missile's state
function Missile:update(dt)

    self.chkBnd()

    -- changing missile y velocity
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    self.left = self.x
    self.right = self.x + self.width
    self.top = self.y
    self.bottom = self.y + self.height
end

-- drawing the missile
function Missile:draw()

    -- drawing the Missile 
    love.graphics.draw(self.texture, self.x, self.y, self.r, 1, 1, self.xo, self.yo)

    -- debugging x and y and collider
    -- love.graphics.rectangle('line', self.x - self.xo, self.y - self.yo, self.width, self.height)    
    -- love.graphics.print('x: ' .. self.x .. ' y: ' .. self.y, 0, 100)
end

-- checking missile missile collision with another object(obj)
function Missile:checkCol(obj)

    if self.dead == false then
        obj_left = obj.x
        obj_right = obj.x + obj.width
        obj_top = obj.y
        obj_bottom = obj.y + obj.height
    
        if self.right > obj_left and
        self.left < obj_right and
        self.bottom > obj_top and
        self.top < obj_bottom then
            self.dead = true
            return true
        else
            return false
        end
    end

end

function Missile:chkBnd()

    -- -- checking if missile reached the boundary
    -- if self.y <= 0 or self.y >= WINDOW_HEIGHT then
    --     self.dead = true
    --     return
    -- elseif self.x <= 0 or self.x >= WINDOW_WIDTH then
    --     self.dead = true
    --     return
    -- end
end