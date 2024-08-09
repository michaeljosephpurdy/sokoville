local System = tiny.processingSystem()

---@param e KeyPressEvent | KeyReleaseEvent
function System:filter(e)
  return e.is_event and (e.key_press or e.key_release)
end

---@param props SystemProps
function System:init(props)
  self.keyboard_state = props.keyboard_state
end

---@param e KeyPressEvent | KeyReleaseEvent
function System:onAdd(e)
  if e.key_press then
    self.keyboard_state:push(e.keycode)
  elseif e.key_release then
    self.keyboard_state:release(e.keycode)
  end
end

function System:postWrap(dt)
  self.keyboard_state:reset()
end

return System
