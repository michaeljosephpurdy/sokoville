local SpriteDrawingSystem = tiny.sortedProcessingSystem()
SpriteDrawingSystem.filter = tiny.requireAll('drawable', 'position')

local default_offset = { x = 0, y = 0 }

---@param props SystemProps
function SpriteDrawingSystem:init(props)
  self.system_props = props
end

---@param e1 Drawable
---@param e2 Drawable
---@return boolean
function SpriteDrawingSystem:compare(e1, e2)
  return (e1.drawable.z_index or 0) < (e2.drawable.z_index or 0)
end

---@param e Drawable | Position
---@param dt number
function SpriteDrawingSystem:process(e, dt)
  if e.drawable.hidden then
    return
  end
  local scale = self.system_props.scale * (e.drawable.scale or 1)
  local x, y = e.position.x * scale, e.position.y * scale
  local offset = e.drawable.offset or default_offset
  local origin_offset = e.drawable.origin_offset or 0
  local rotation = e.drawable.rotation or 0
  love.graphics.draw(
    e.drawable.sprite,
    x + offset.x,
    y + offset.y,
    rotation,
    scale,
    scale,
    origin_offset,
    origin_offset
  )
end

return SpriteDrawingSystem
