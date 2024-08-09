local GameStepSystem = tiny.system()

---@param e GameStepAdvanceEvent
function GameStepSystem:filter(e)
  return e.is_event and e.game_step_advance
end

---@param props SystemProps
function GameStepSystem:init(props)
  self.system_props = props
end

---@param e GameStepAdvanceEvent
function GameStepSystem:onRemove(e)
  self.system_props.step = self.system_props.step + 1
end

return GameStepSystem
