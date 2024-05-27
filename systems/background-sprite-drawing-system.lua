local BackgroundSpriteDrawingSystem = tiny.processingSystem()
BackgroundSpriteDrawingSystem.filter = tiny.requireAll('draw_background', 'sprite', 'x', 'y')
BackgroundSpriteDrawingSystem.is_draw_system = true
local default_offset = { x = 0, y = 0 }

function BackgroundSpriteDrawingSystem:process(e, dt)
  local offset = e.sprite_offest or default_offset
  love.graphics.draw(e.sprite, e.x + offset.x, e.y + offset.y)
end

return BackgroundSpriteDrawingSystem
