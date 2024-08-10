local GameStepSystem = tiny.system()

---@param e GameStepIncrementEvent | GameStepDecrementEvent
function GameStepSystem:filter(e)
  return e.is_event and (e.game_step_increment or e.game_step_decrement)
end

---@param props SystemProps
function GameStepSystem:init(props)
  self.system_props = props
end

---@param e GameStepIncrementEvent | GameStepDecrementEvent
function GameStepSystem:onAddEvent(e)
  if e.game_step_increment then
    self.system_props.step = self.system_props.step + 1
    log('incremented game_step to %s', self.system_props.step)
  elseif e.game_step_decrement then
    self.system_props.step = self.system_props.step - 1
    if self.system_props.step < 1 then
      self.system_props.step = 1
    end
    log('decremented game_step to %s', self.system_props.step)
  end
end

return GameStepSystem
