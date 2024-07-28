local GridBasedCollisionResolutionSystem = tiny.processingSystem()
GridBasedCollisionResolutionSystem.filter = tiny.requireAll('snap_to_grid', 'x', 'y')

function GridBasedCollisionResolutionSystem:initialize() end

function GridBasedCollisionResolutionSystem:onAdd(e) end

function GridBasedCollisionResolutionSystem:onRemove(e) end

function GridBasedCollisionResolutionSystem:process(e, dt)
  if e.moved then
    logger:to_file(e)
    EntityGridData:move_data(e.old_x, e.old_y, e.new_x, e.new_y, e)
    e.x = e.new_x
    e.y = e.new_y
  end
  e.moved = false
end

return GridBasedCollisionResolutionSystem
