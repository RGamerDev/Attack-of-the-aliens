offlineManager = Object.extend(Object)

function offlineManager:new()

    players = {
        [1] = Player(WINDOW_WIDTH * 0.1, WINDOW_HEIGHT * 0.5, 90),
        [2] = Player(WINDOW_WIDTH * 0.9, WINDOW_HEIGHT * 0.5, 270)
    }
    
    -- setting background
    bg = love.graphics.newImage('Graphics/stars_milky_way_space_116893_1920x1080.jpg')

end

function offlineManager:update(dt)
    
    if players[1].dead == false and players[2].dead == false then

        mngUtil:chkMovement(players[1], 'w', 's', dt)
        mngUtil:chkMovement(players[2], 'up', 'down', dt)
        
        for key, player in ipairs(players) do
            player:update(dt, players[(key % #players) + 1])
            player:move('y', dt)
        end
       
    elseif players[1].dead == true then
        loadMode('status','Player 2 Wins!')
    elseif players[2].dead == true then
        loadMode('status','Player 1 Wins!')
    end
end

function offlineManager:draw()
    love.graphics.draw(bg)
    
    for _, player in ipairs(players) do
        player:draw()
    end

    -- love.graphics.print('Player 1 r: ' .. math.deg(players[1].r), 0, 0)
    -- love.graphics.print('Player 2 r: ' .. math.deg(players[2].r), 0, 15)
    -- love.graphics.print('Player 1 x: ' .. players[1].x + players[1].xo, 0, 30)
    -- love.graphics.print('Player 2 x: ' .. players[2].x + players[2].xo, 0, 45)
    -- love.graphics.print('Player 1 y: ' .. players[1].y + players[1].yo, 0, 60)
    -- love.graphics.print('Player 2 y: ' .. players[2].y + players[2].yo, 0, 75)
    -- love.graphics.print('Player 1 missile x: ' .. players[1].cx + players[1].cos * 100, 0, 120)
    -- love.graphics.print('Player 1 missile y: ' .. players[1].cy + players[1].sin * 100, 0, 135)
    -- love.graphics.print('Player 2 missile x: ' .. players[2].cx + players[2].cos * 100, 0, 150)
    -- love.graphics.print('Player 2 missile y: ' .. players[2].cy + players[2].sin * 100, 0, 165)
    -- love.graphics.print(players[1].dead == false and 'false' or 'true', 0, 0)
    -- love.graphics.print(players[2].dead == false and 'false' or 'true', 0, 15)
end

function offlineManager:keypressed(key)
    if key == 'space' then
        players[1]:shoot()
    elseif key == 'rctrl' then
        players[2]:shoot()
    end
end