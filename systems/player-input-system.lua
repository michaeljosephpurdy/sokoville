local PlayerInputSystem = tiny.processingSystem()
PlayerInputSystem.filter = tiny.requireAny('is_player', 'key_press', 'key_release')

function PlayerInputSystem:initialize(props)
  ---@map string boolean
  self.controls = {}
  self.released = {}
end

function PlayerInputSystem:onAdd(e)
  if e.key_press and e.is_event then
    self.controls[e.keycode] = true
  end
  if e.key_release and e.is_event then
    self.controls[e.keycode] = false
    self.released[e.keycode] = true
  end
end

function PlayerInputSystem:onRemove(e)
  if e.key_release and e.is_event then
    self.released[e.keycode] = false
  end
end

function PlayerInputSystem:process(e, dt)
  if e.is_event then
    return
  end
  e.dx, e.dy = 0, 0
  if self.released['left'] then
    e.dx = -1
  elseif self.released['right'] then
    e.dx = 1
  end
  if self.released['up'] then
    e.dy = -1
  elseif self.released['down'] then
    e.dy = 1
  end
  if self.released['space'] then
    self.world:addEntity(RewindEvent())
  end
  if e.dx ~= 0 or e.dy ~= 0 then
    self.world:addEntity(GameTickEvent())
  end
end

return PlayerInputSystem
