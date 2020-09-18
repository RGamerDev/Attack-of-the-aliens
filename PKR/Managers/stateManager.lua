states = 
{
    ['menu'] = 
    {
        ['load'] = function ()
            mnManager = menuManager()
        end,

        ['update'] = function (dt)
            mnManager:update(dt)
        end,

        ['draw'] = function ()
            mnManager:draw()
        end
    },

    ['normal'] = 
    {
        ['load'] = function ()
            -- instantiating the levelManager
            lvlMngr = levelManager()
        end,

        ['update'] = function (dt)
            lvlMngr:update(dt)
        end,

        ['draw'] = function ()
            lvlMngr:draw()
        end 
    },

    ['classic'] = 
    {
        ['load'] = function ()
            -- instantiating the clasicManager
            clcMngr = classicManager()
        end,

        ['update'] = function (dt)
            clcMngr:update(dt)
        end,

        ['draw'] = function ()
            clcMngr:draw()
        end 
    },

    ['offline'] =
    {
        ['load'] = function ()
            offMngr = offlineManager()
        end,

        ['update'] = function (dt)
            offMngr:update(dt)
        end,

        ['draw'] = function ()
            offMngr:draw()
        end,
    },

    ['status'] = 
    {
        ['load'] = function (status)
            st = Status(status)
        end,

        ['update'] = function (dt)
            st:update(dt)
        end,

        ['draw'] = function ()
            st:draw()
        end
    }
}

