local SingletonManagerSystem = tiny.processingSystem()
SingletonManagerSystem.filter = tiny.requireAll('is_singleton')

function SingletonManagerSystem:onRemove(e)
  self.world:addEntity(e)
end

return SingletonManagerSystem
