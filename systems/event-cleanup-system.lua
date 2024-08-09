local EventCleanupSystem = tiny.processingSystem()

---@param e Perishable | Event
function EventCleanupSystem:filter(e)
  return e.is_event and not e.time_to_live
end

---@param e Event
---@param dt number
function EventCleanupSystem:process(e, dt)
  print('removing ' .. json.encode(e))
  self.world:removeEntity(e)
end

return EventCleanupSystem
