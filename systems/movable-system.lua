local MovableSystem = tiny.processingSystem()

---@param e Movable | Position
function MovableSystem:filter(e)
  return e.movable and e.position
end

---@param props SystemProps
function MovableSystem:init(props)
  self.system_props = props
  self.grid_size = props.game_grid_size
  self.keyboard_state = props.keyboard_state
end

---@param e Movable | Position
function MovableSystem:onAdd(e)
  e.movable.x = e.position.x
  e.movable.y = e.position.y
end

---@param e Movable | Position
---@param dt number
function MovableSystem:process(e, dt)
  if self.keyboard_state:is_key_just_released('-') then
    self.system_props.scale = self.system_props.scale - 0.5
  end
  if self.keyboard_state:is_key_just_released('=') then
    self.system_props.scale = self.system_props.scale + 0.5
  end
  e.movable.x = e.position.x
  e.movable.y = e.position.y
  if e.movable.left then
    e.movable.x = e.position.x - self.grid_size
  elseif e.movable.right then
    e.movable.x = e.position.x + self.grid_size
  end
  if e.movable.up then
    e.movable.y = e.position.y - self.grid_size
  elseif e.movable.down then
    e.movable.y = e.position.y + self.grid_size
  end
end

return MovableSystem
