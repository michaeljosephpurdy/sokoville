local GridBasedMovementSystem = tiny.processingSystem()
GridBasedMovementSystem.filter = tiny.requireAll('snap_to_grid', 'x', 'y', 'dx', 'dy')

function GridBasedMovementSystem:initialize() end

function GridBasedMovementSystem:process(e, dt)
  e.x = e.x + e.dx * GLOBAL.grid_size
  e.y = e.y + e.dy * GLOBAL.grid_size
end

return GridBasedMovementSystem
