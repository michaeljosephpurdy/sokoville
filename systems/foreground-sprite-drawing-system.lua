local ForegroundSpriteDrawingSystem = tiny.processingSystem()
ForegroundSpriteDrawingSystem.filter = tiny.requireAll('draw_foreground', 'sprite', 'x', 'y')
ForegroundSpriteDrawingSystem.is_draw_system = true
local default_offset = { x = 0, y = 0 }

function ForegroundSpriteDrawingSystem:process(e, dt)
  local offset = e.sprite_offset or default_offset
  love.graphics.draw(e.sprite, e.x + offset.x, e.y + offset.y)
end

return ForegroundSpriteDrawingSystem
