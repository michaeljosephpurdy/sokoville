local EventCleanupSystem = tiny.processingSystem()
local rejection_filter = tiny.rejectAll('perishable')
EventCleanupSystem.filter = tiny.requireAll(rejection_filter, 'is_event')

---@param e Event
---@param dt number
function EventCleanupSystem:process(e, dt)
  print('removing ' .. json.encode(e))
  self.world:removeEntity(e)
end

return EventCleanupSystem
