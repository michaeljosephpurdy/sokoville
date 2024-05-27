local SpriteDrawingSystem = tiny.processingSystem()
local rejection_filter = tiny.rejectAny('draw_foreground', 'draw_background')
SpriteDrawingSystem.filter = tiny.requireAll(rejection_filter, 'sprite', 'x', 'y')
SpriteDrawingSystem.is_draw_system = true
local default_offset = { x = 0, y = 0 }

function SpriteDrawingSystem:process(e, dt)
  local x, y = e.x, e.y
  local offset = e.sprite_offset or default_offset
  love.graphics.draw(e.sprite, x + offset.x, y + offset.y)
end

return SpriteDrawingSystem
