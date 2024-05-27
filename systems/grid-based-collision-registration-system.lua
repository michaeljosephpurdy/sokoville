local GridBasedCollisionRegistrationSystem = tiny.processingSystem()
GridBasedCollisionRegistrationSystem.filter = tiny.requireAll('x', 'y')

function GridBasedCollisionRegistrationSystem:process(e, dt) end

return GridBasedCollisionRegistrationSystem
