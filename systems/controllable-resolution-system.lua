local ControllableResolutionSystem = tiny.processingSystem()

---@param e Controllable | Movable | Position
function ControllableResolutionSystem:filter(e)
  return e.controllable and e.movable and e.position
end

---@param props SystemProps
function ControllableResolutionSystem:init(props)
  self.system_props = props
end

---@params props Controllable | Movable | Position
function ControllableResolutionSystem:onAdd(e)
  e.controllable.x = e.position.x
  e.controllable.y = e.position.y
end

---@param e Controllable | Movable | Position
---@param dt number
function ControllableResolutionSystem:process(e, dt)
  -- if the controllable entity has moved
  -- then we need to increment the game step
  if e.controllable.x ~= e.position.x or e.controllable.y ~= e.position.y then
    self.world:addEvent({
      is_event = true,
      game_step_increment = true,
    }--[[@as GameStepIncrementEvent]])
  end
  e.controllable.x = e.position.x
  e.controllable.y = e.position.y
end

return ControllableResolutionSystem
