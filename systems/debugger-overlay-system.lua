local DebuggerOverlaySystem = tiny.system()

---@param props SystemProps
function DebuggerOverlaySystem:init(props)
  self.props = props
  self.world_info = [[
  systems: %s
  entities: %s
  ]]
end

function DebuggerOverlaySystem:update(dt)
  if self.props.keyboard_state:is_key_just_released('\\') then
    self.props.display_debug = not self.props.display_debug
  end
  if not self.props.display_debug then
    return
  end
  love.graphics.push()
  love.graphics.origin()
  love.graphics.print(string.format(self.world_info, self.world:getSystemCount(), self.world:getEntityCount()))
  love.graphics.pop()
end

return DebuggerOverlaySystem
