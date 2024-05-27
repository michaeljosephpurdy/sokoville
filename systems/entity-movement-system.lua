local EntityMovementSystem = tiny.processingSystem()
EntityMovementSystem.filter = tiny.requireAll('x', 'y', 'dx', 'dy')

return EntityMovementSystem
