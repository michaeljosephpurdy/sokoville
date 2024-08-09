local CollisionRegistrationSystem = tiny.processingSystem()

---@param e Position | Collidable
function CollisionRegistrationSystem:filter(e)
  return e.collidable and e.position
end

---@param props SystemProps
function CollisionRegistrationSystem:init(props)
  self.collision_grid = props.collision_grid
end

---@param e Collidable | Position
function CollisionRegistrationSystem:onAdd(e)
  self.collision_grid:register(e)
end

---@param e Collidable | Position
function CollisionRegistrationSystem:onRemove(e)
  self.collision_grid:remove(e)
end

return CollisionRegistrationSystem
