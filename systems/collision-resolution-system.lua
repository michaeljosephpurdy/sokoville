local CollisionResolutionSystem = tiny.processingSystem()
---@param e Position | Collidable
function CollisionResolutionSystem:filter(e)
  return e.collidable and e.position and not e.collidable.is_solid
end

---@param props SystemProps
function CollisionResolutionSystem:init(props)
  self.collision_grid = props.collision_grid
end

---@param e Collidable | Position
function CollisionResolutionSystem:onAdd(e)
  e.collidable.x = e.position.x
  e.collidable.y = e.position.y
end

---@param e Collidable | Position
function CollisionResolutionSystem:onRemove(e) end

---@param e Collidable | Position
function CollisionResolutionSystem:process(e, dt)
  self.collision_grid:update(e, e.collidable.x, e.collidable.y)
  e.position.x = e.collidable.x
  e.position.y = e.collidable.y
end

return CollisionResolutionSystem
