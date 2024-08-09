local DebuggerOverlaySystem = tiny.system()

---@param props SystemProps
function DebuggerOverlaySystem:init(props)
  self.system_props = props
  self.world_info = [[
  systems: %s
  entities: %s
  step: %s
  ]]
end

function DebuggerOverlaySystem:update(dt)
  if self.system_props.keyboard_state:is_key_just_released('\\') then
    self.system_props.display_debug = not self.system_props.display_debug
  end
  if not self.system_props.display_debug then
    return
  end
  love.graphics.push()
  love.graphics.origin()
  love.graphics.print(
    string.format(self.world_info, self.world:getSystemCount(), self.world:getEntityCount(), self.system_props.step)
  )
  love.graphics.pop()
end

return DebuggerOverlaySystem
