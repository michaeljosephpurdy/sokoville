local GridBasedCollisionRegistrationSystem = tiny.processingSystem()
GridBasedCollisionRegistrationSystem.filter = tiny.requireAll('snap_to_grid', 'x', 'y')

function GridBasedCollisionRegistrationSystem:onAdd(e)
  e.grid_id = love.math.random()
  e.old_x = e.x
  e.old_y = e.y
  if e.is_tile then
    TileGridData:save_data(e.x, e.y, e)
  else
    EntityGridData:save_data(e.x, e.y, e)
  end
end

function GridBasedCollisionRegistrationSystem:onRemove(e)
  if e.is_tile then
    TileGridData:save_data(e.x, e.y, nil)
  else
    EntityGridData:save_data(e.x, e.y, nil)
  end
end

return GridBasedCollisionRegistrationSystem
