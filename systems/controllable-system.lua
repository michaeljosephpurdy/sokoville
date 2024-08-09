local ControllableSystem = tiny.processingSystem()

---@param e Controllable | Movable
function ControllableSystem:filter(e)
  return e.controllable and e.movable
end

---@param props SystemProps
function ControllableSystem:init(props)
  self.keyboard_state = props.keyboard_state
end

---@param e Controllable | Movable
---@param dt number
function ControllableSystem:process(e, dt)
  if not e.controllable.is_active then
    return
  end
  e.movable.left = self.keyboard_state:is_key_just_released('left') or self.keyboard_state:is_key_just_released('a')
  e.movable.right = self.keyboard_state:is_key_just_released('right') or self.keyboard_state:is_key_just_released('d')
  e.movable.up = self.keyboard_state:is_key_just_released('up') or self.keyboard_state:is_key_just_released('w')
  e.movable.down = self.keyboard_state:is_key_just_released('down') or self.keyboard_state:is_key_just_released('s')
  if e.movable.left or e.movable.right or e.movable.down or e.movable.left then
    self.world:addEntity({
      is_event = true,
      game_step_advance = true,
    }--[[@as GameStepAdvanceEvent]])
  end
end

return ControllableSystem
