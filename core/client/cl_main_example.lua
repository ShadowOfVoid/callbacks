--[[

[CLIENTSIDE]

-- Grabbing the code for the callbacks.
Callbacks = exports['callbacks']:FetchCallbacks()

-- Just a simple command used as an example. [Callbacks:TriggerCallback('callback_name', cb function, data sent to the server)]
RegisterCommand('cbserver', function()
    Callbacks:TriggerCallback('Test:ServerCallback', function(data)
        print(data)
    end, 'Console print yeee')
end)


-- This is the string we will fetch from the client in the example serverside.
local clientString = 'I eat ass.'

-- Registering the callbacks (Client Callbacks).
function registerCallbacks()
    Callbacks:RegisterCallback('Test:ClientCallback', function(data, cb)
        print(data)
        cb(clientString)
    end)
end
registerCallbacks()

]]
