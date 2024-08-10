local RewindPersistanceSystem = tiny.processingSystem()

---@param e Rewindable
function RewindPersistanceSystem:filter(e)
  return e.rewindable
end

---@param e GameStepIncrementEvent
function RewindPersistanceSystem:onAddEvent(e)
  if e.game_step_increment then
    self.active = true
  end
end

---@param props SystemProps
function RewindPersistanceSystem:init(props)
  self.system_props = props
  self.record_rewind = false
end

---@param e Rewindable | Position
function RewindPersistanceSystem:onAdd(e)
  e.rewindable.previous = {}
  local position = { x = e.position.x, y = e.position.y }
  e.rewindable.previous[self.system_props.step] = { position = position }
end

---@param e Rewindable | Position
---@param dt number
function RewindPersistanceSystem:process(e, dt)
  local position = { x = e.position.x, y = e.position.y }
  e.rewindable.previous[self.system_props.step] = { position = position }
  log('saved position (%s,%s) at step: %s for %s', position.x, position.y, self.system_props.step, e.id)
end

function RewindPersistanceSystem:postWrap(dt)
  self.active = false
end

return RewindPersistanceSystem
