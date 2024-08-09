local PerishableSystem = tiny.processingSystem()
PerishableSystem.filter = tiny.requireAll('perishable')

---@param e Perishable
---@param dt number
function PerishableSystem:process(e, dt)
  e.time_to_live = e.time_to_live - dt
  if e.time_to_live < 0 then
    self.world:removeEntity(e)
  end
end

return PerishableSystem
