local SpriteDrawingSystem = tiny.processingSystem()
local rejection_filter = tiny.rejectAny('draw_foreground', 'draw_background')
SpriteDrawingSystem.filter = tiny.requireAll(rejection_filter, 'sprite', 'x', 'y')
SpriteDrawingSystem.is_draw_system = true
local default_offset = { x = 0, y = 0 }

function SpriteDrawingSystem:initialize()
  self.images = {}
end

function SpriteDrawingSystem:onAdd(e)
  if not self.images[e.sprite] then
    self.images[e.sprite] = love.graphics.newImage(e.sprite)
  end
end

function SpriteDrawingSystem:process(e, dt)
  local x, y = e.x, e.y
  local offset = e.sprite_offset or default_offset
  if e.snap_to_grid then
    x = x * EntityGridData.grid_size
    y = y * EntityGridData.grid_size
  end
  love.graphics.draw(self.images[e.sprite], x + offset.x, y + offset.y)
end

return SpriteDrawingSystem
