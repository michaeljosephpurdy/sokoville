local BackgroundSpriteDrawingSystem = tiny.processingSystem()
BackgroundSpriteDrawingSystem.filter = tiny.requireAll('draw_background', 'sprite', 'x', 'y')
BackgroundSpriteDrawingSystem.is_draw_system = true
local default_offset = { x = 0, y = 0 }

function BackgroundSpriteDrawingSystem:process(e, dt)
  local x, y = e.x, e.y
  local offset = e.sprite_offset or default_offset
  if e.snap_to_grid then
    x = x * EntityGridData.grid_size
    y = y * EntityGridData.grid_size
  end
  love.graphics.draw(e.sprite, x + offset.x, y + offset.y)
end

return BackgroundSpriteDrawingSystem
