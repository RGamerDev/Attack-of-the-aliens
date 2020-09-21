-- Constants
WINDOW_HEIGHT = 1080
WINDOW_WIDTH = 1920

math.randomseed(os.time())

-- Loading the game first
function love.load()

    love.graphics.origin()

    -- Linking dependencies
    Object = require "classic"

    
    require 'Managers/stateManager'
    require 'Managers/menuManager'
    require 'Managers/levelManager'
    require 'Managers/classicManager'
    require 'Managers/offlineManager'
    require 'Managers/onlineManager'
    require 'MyUtilLibs/matchStatus'
    require 'MyUtilLibs/ManagerUtil'
    
    mngUtil = ManagerUtil()

    -- Setting the window size
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = true,
        vsync = false,
        resizable = false,
        display = 1
    })

    -- setting title
    love.window.setTitle('Attack of the aliens!')

    -- setting font
    Roboto = love.graphics.newFont('Graphics/Fonts/Roboto/Roboto-Regular.ttf', 50)
    love.graphics.setFont(Roboto)

    --setting paused state
    state = 'active'

    -- debugging modes
    Mode = 'menu'

    loadMode(Mode)
end

-- Updating every frame
function love.update(dt)
    if state == 'active' then
        states[Mode]['update'](dt)
    end
end

-- Drawing to the window
function love.draw()
    states[Mode]['draw']()

    -- Printing FPS counter
    love.graphics.print('FPS: ' .. love.timer.getFPS(), 25, 25)
end

-- Checking for key presses
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'return' then
        state = state == 'active' and 'paused' or 'active'
    elseif state ~= 'paused' and Mode ~= 'menu' and Mode ~= 'status' then
        states[Mode]['keypressed'](key)
    end
end

-- function for loading new Mode
function loadMode(mode, status)

    Mode = mode

    if status == nil then
        states[Mode]['load']()
    else
        states[Mode]['load'](status)
    end

end