local GridBasedMovementSystem = tiny.processingSystem()
GridBasedMovementSystem.filter = tiny.requireAll('is_player', 'x', 'y', 'dx', 'dy')

function GridBasedMovementSystem:initialize() end

function GridBasedMovementSystem:onAdd(e)
  e.dx, e.dy = 0, 0
end

function GridBasedMovementSystem:process(e, dt)
  local moved = self:move(e.dx, e.dy, e)
  if moved then
    self.world:addEntity(GameTickEvent())
  end
end

function GridBasedMovementSystem:move(dx, dy, e, depth)
  depth = depth or 1
  e.old_x = e.x
  e.old_y = e.y
  e.new_x = e.x + dx
  e.new_y = e.y + dy
  -- we didn't move
  if e.old_x == e.new_x and e.old_y == e.new_y then
    e.moved = false
    return false
  end
  -- we moved, so now we need to check collisions
  -- 2. check if other is solid, if it is, then stop
  -- 3. attempt to move other entity
  --    if they can move, then you can move and rollforward movement
  local other = EntityGridData:get_data(e.new_x, e.new_y)
  if not other then
    logger:to_file(depth .. ' no other, free to move')
    e.moved = true
    return true
  end
  if other.is_passable then
    logger:to_file(depth .. ' other is passable')
    e.moved = true
    return true
  end

  -- we have a collision, so we need to rollback
  -- rollback
  e.x = e.old_x
  e.y = e.old_y
  if not other.is_pushable or other.is_solid or other.immobile then
    logger:to_file(depth .. ' other is not moveable!')
    e.moved = false
    return false
  end
  local other_moved = self:move(dx, dy, other, depth + 1)
  if other_moved then
    logger:to_file(other)
    e.moved = true
    return true
  end
  -- we can rollforward if moved is true
  e.moved = true
  return true
end

return GridBasedMovementSystem
