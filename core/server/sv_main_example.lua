--[[

[SERVERSIDE]

-- Grabbing the code for the callbacks.
Callbacks = exports['callbacks']:FetchCallbacks()

-- Just a simple command used as an example. [Callbacks:TriggerCallback('callback_name', cb function, data sent to the client, the player the callback is targeting)]
-- You could replace [src] at the end of the callback code with -1 to fire for everyone, you could loop thru a player table, etc... Whatever you want breh.
RegisterCommand('cbclient', function(source)
    local src = source
    Callbacks:TriggerCallback('Test:ClientCallback', function(data)
        print(data)
    end, 'Grabbing Data From Client', src)
end)

-- Registering the callbacks (Server Callbacks).
function registerCallbacks()
    Callbacks:RegisterCallback('Test:ServerCallback', function(data, source, cb)
        local src = source
        -- Do stuff with src
        print(data)
        cb('Client Recieved Data')
    end)
end
registerCallbacks()

]]
