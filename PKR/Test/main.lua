function love.load()

    WINDOW_WIDTH, WINDOW_HEIGHT, flag = love.window.getMode()

    player1 = {
        name = 'player1',
        texture = love.graphics.newImage('spaceShips_009.png'),
        x = 200,
        y = 250,
        r = 0
    }

    player1.width = player1.texture:getWidth()
    player1.height = player1.texture:getHeight()
    player1.xo = player1.width / 2
    player1.yo = player1.height / 2
    player1.sin = math.sin(player1.r)
    player1.cos = math.cos(player1.r)
    
    player2 = {
        name = 'player2',
        x = 500,
        y = 250,
        width = 100,
        height = 100,
        xo = 100 / 2,
        yo = 100 / 2
    }

    speed = 200
    mode = 'fill'
end

function love.update(dt)


    if love.keyboard.isDown('w') then player1.y = player1.y - speed * dt end
    if love.keyboard.isDown('s') then player1.y = player1.y + speed * dt end
    if love.keyboard.isDown('a') then player1.x = player1.x - speed * dt end
    if love.keyboard.isDown('d') then player1.x = player1.x + speed  * dt end

    if checkCollision(player1, player2) then
        mode = 'line'    
    else 
        mode = 'fill'
    end
end

function love.draw()
    love.graphics.draw(player1.texture, player1.x, player1.y, math.rad(player1.r), 1, 1, player1.xo, player1.yo)
    love.graphics.rectangle('line', player1.x - player1.xo, player1.y - player1.yo, player1.width, player1.height)
    -- love.graphics.rectangle('line', player1.x, player1.y, player1.width, player1.height)
    love.graphics.rectangle(mode, player2.x, player2.y, player2.width, player2.height)
end

function checkCollision(a, b)
    --With locals it's common usage to use underscores instead of camelCasing
    local a_left = a.x - a.xo
    local a_right = a.x + a.width - a.xo
    local a_top = a.y - a.yo
    local a_bottom = a.y + a.height - a.yo

    local b_left = b.x
    local b_right = b.x + b.width
    local b_top = b.y
    local b_bottom = b.y + b.height

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