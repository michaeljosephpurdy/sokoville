local PlayerInputSystem = tiny.processingSystem()
PlayerInputSystem.filter = tiny.requireAny('is_player')

function PlayerInputSystem:initialize(props)
  self.keyboard_state = props.keyboard_state
end

function PlayerInputSystem:process(e, dt)
  e.dx, e.dy = 0, 0
  if self.keyboard_state:is_key_just_released('left') then
    e.dx = -1
  elseif self.keyboard_state:is_key_just_released('right') then
    e.dx = 1
  end
  if self.keyboard_state:is_key_just_released('up') then
    e.dy = -1
  elseif self.keyboard_state:is_key_just_released('down') then
    e.dy = 1
  end
  if self.keyboard_state:is_key_just_released('space') then
    self.world:addEntity(RewindEvent())
  end
end

return PlayerInputSystem
