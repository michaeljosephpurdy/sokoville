local RewindPlaybackSystem = tiny.processingSystem()

---@param props SystemProps
function RewindPlaybackSystem:init(props)
  self.system_props = props
end

---@param e Rewindable
function RewindPlaybackSystem:filter(e)
  return e.rewindable
end

---@param e GameStepDecrementEvent
function RewindPlaybackSystem:onAddEvent(e)
  if e.game_step_decrement then
    self.active = true
  end
end

---@param e Rewindable | Position | Collidable | Movable | Controllable
---@param dt number
function RewindPlaybackSystem:process(e, dt)
  local previous = e.rewindable.previous[self.system_props.step]
  if previous and previous.position then
    log('rewind to position (%s,%s) for %s', previous.position.x, previous.position.y, e.id)
    -- undo all movement
    -- HACK: this will be a PITA to keep updating (all positions) but might just be what has to happen.
    -- I thought `position-sync-system` would solve this, but would need an additional property on all
    -- entities just to ensure it's not always syncing...
    -- So, gonna live with this here.
    if e.collidable then
      self.system_props.collision_grid:update(e, previous.position.x, previous.position.y)
      e.collidable.x = previous.position.x
      e.collidable.y = previous.position.y
    end
    if e.movable then
      e.movable.x = previous.position.x
      e.movable.y = previous.position.y
    end
    if e.controllable then
      e.controllable.x = previous.position.x
      e.controllable.y = previous.position.y
    end
    e.position.x = previous.position.x
    e.position.y = previous.position.y
  end
  e.rewindable.previous[self.system_props.step] = nil
end

---@param dt any
function RewindPlaybackSystem:postWrap(dt)
  self.active = false
end

return RewindPlaybackSystem
