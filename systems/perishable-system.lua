local PerishableSystem = tiny.processingSystem()

---@param e Perishable
function PerishableSystem:filter(e)
  return e.time_to_live
end

---@param e Perishable
---@param dt number
function PerishableSystem:process(e, dt)
  e.time_to_live = e.time_to_live - dt
  if e.time_to_live < 0 then
    self.world:removeEntity(e)
  end
end

return PerishableSystem
