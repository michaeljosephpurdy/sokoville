local DebuggerOverlaySystem = tiny.processingSystem()
DebuggerOverlaySystem.filter = tiny.requireAll('print_debug')

function DebuggerOverlaySystem:postWrap()
  love.graphics.push()
  love.graphics.print(#self.entities, 5, 5)
  for i, ent in ipairs(self.entities) do
    local message = nil
    if ent.get_value then
      message = ent.get_value()
    else
      message = logger:parse_msg(ent)
    end
    love.graphics.print(message, 5, i * 16)
  end
  love.graphics.pop()
end

return DebuggerOverlaySystem
