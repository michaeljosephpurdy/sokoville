local CollisionDetectionSystem = tiny.processingSystem()

---@param e Collidable | Position | Movable
---@return boolean
function CollisionDetectionSystem:filter(e)
  if not e.collidable or not e.position or not e.movable then
    return false
  end
  if e.collidable.is_solid then
    return false
  end
  return e.collidable.is_detector
end

---@param props SystemProps
function CollisionDetectionSystem:init(props)
  self.collision_grid = props.collision_grid
end

---@param e Pushable | Collidable
---@return boolean pushed
function CollisionDetectionSystem:push_entity(e, dx, dy, _depth)
  local depth = _depth or 0
  local new_x, new_y = e.collidable.x + dx, e.collidable.y + dy
  ---@type table<number, Pushable | Collidable>
  local entities = self.collision_grid:single_query(new_x, new_y)
  local moved = true
  for _, other in pairs(entities) do
    if not moved or other == e then
      -- do nothing
    elseif other.pushable then
      moved = self:push_entity(other, dx, dy, depth + 1)
    elseif other.collidable.is_solid then
      moved = false
    end
  end
  if moved then
    e.collidable.x, e.collidable.y = new_x, new_y
  end
  return moved
end

---@param e Collidable | Position | Movable
function CollisionDetectionSystem:process(e, dt)
  local moved_horizontal = e.position.x ~= e.movable.x
  local moved_vertical = e.position.y ~= e.movable.y
  -- if the entity hasn't moved, then no need for checking collisions
  if not moved_horizontal and not moved_vertical then
    return
  end
  local dx = e.movable.x - e.position.x
  local dy = e.movable.y - e.position.y
  -- first, we'll check horizontal collisions
  local solid_on_horizontal = false
  if moved_horizontal then
    ---@type table<number, Pushable | Collidable>
    local horizontal_collisions = self.collision_grid:single_query(e.movable.x, e.position.y)
    for _, other in pairs(horizontal_collisions) do
      if other == e then
      elseif other.pushable then
        local moved = self:push_entity(other, dx, dy, other.collidable.depth)
        if not moved then
          solid_on_horizontal = true
        end
      elseif other.collidable.is_solid then
        solid_on_horizontal = true
        break
      end
    end
  end
  -- second, we'll check vertical collisions
  local solid_on_vertical = false
  if moved_vertical then
    ---@type table<number, Pushable | Collidable>
    local vertical_collisions = self.collision_grid:single_query(e.position.x, e.movable.y)
    for _, other in pairs(vertical_collisions) do
      if other == e then
      elseif other.pushable then
        local moved = self:push_entity(other, dx, dy, other.collidable.depth)
        if not moved then
          solid_on_vertical = true
        end
      elseif other.collidable.is_solid then
        solid_on_vertical = true
        break
      end
    end
  end
  e.collidable.x = e.movable.x
  e.collidable.y = e.movable.y
  if solid_on_horizontal then
    e.collidable.x = e.position.x
  end
  if solid_on_vertical then
    e.collidable.y = e.position.y
  end
end

return CollisionDetectionSystem
