---------------------------
-- Callbacks --
---------------------------
local cl_Callbacks = {}
local sv_Callbacks = {}

Callbacks = {
    TriggerCallback = function(self, name, cb, data, player)
        local e = 'base:Client:Callback:'
        local sendEvent = e..'' ..name
        local returnEvent = e..''..name..'_return' 
        if not cl_Callbacks[returnEvent] then
            cl_Callbacks[returnEvent] = cb
            RegisterServerEvent(returnEvent)
            AddEventHandler(returnEvent, function(args)
                local cb = cl_Callbacks[returnEvent]
                cb(args)
            end)
        end
        TriggerClientEvent(sendEvent, player, data)
    end,
    RegisterCallback = function(self, name, cb)
        if not sv_Callbacks[name] then
            local e = 'base:Server:Callback:'..name
            sv_Callbacks[name] = cb
            RegisterServerEvent(e)
            AddEventHandler(e, function(args)
                local src = source
                sv_Callbacks[name](args, src, function(data)
                    TriggerClientEvent(e.. '_return', src, data)
                end)
            end)
        end
    end
}

---------------------------
-- Export --
---------------------------
exports('FetchCallbacks', function()
    return Callbacks
end)