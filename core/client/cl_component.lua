---------------------------
-- Callbacks --
---------------------------
local cl_Callbacks = {}
local sv_Callbacks = {}

Callbacks = {
    TriggerCallback = function(self, name, cb, data)
        local e = 'base:Server:Callback:'
        local sendEvent = e..'' ..name
        local returnEvent = e..''..name..'_return' 
        if not sv_Callbacks[returnEvent] then
            sv_Callbacks[returnEvent] = cb
            RegisterNetEvent(returnEvent)
            AddEventHandler(returnEvent, function(args)
                local cb = sv_Callbacks[returnEvent]
                cb(args)
            end)
        end
        TriggerServerEvent(sendEvent, data)
    end,
    RegisterCallback = function(self, name, cb)
        if not cl_Callbacks[name] then
            local e = 'base:Client:Callback:'..name
            cl_Callbacks[name] = cb
            RegisterNetEvent(e)
            AddEventHandler(e, function(args)
                cl_Callbacks[name](args, function(data)
                    TriggerServerEvent(e.. '_return', data)
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