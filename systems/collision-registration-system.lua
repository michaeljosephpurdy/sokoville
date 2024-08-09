local CollisionRegistrationSystem = tiny.processingSystem()
CollisionRegistrationSystem.filter = tiny.requireAll('collidable', 'position')

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
