local PositionSyncSystem = tiny.processingSystem()

---@param e Position
function PositionSyncSystem:filter(e)
  return e.position
end

---@param props SystemProps
function PositionSyncSystem:init(props)
  self.system_props = props
  -- TODO: Maybe re-enable this system?
  self.active = false
end

---@param e Position | Collidable | Movable | Controllable
---@param dt number
function PositionSyncSystem:process(e, dt)
  if e.collidable then
    e.collidable.x = e.position.x
    e.collidable.y = e.position.y
    log(
      'synced position (%s,%s) to collidable (%s,%s) for %s',
      e.position.x,
      e.position.y,
      e.collidable.x,
      e.collidable.y,
      e.id
    )
  end
  if e.movable then
    e.movable.x = e.position.x
    e.movable.y = e.position.y
    log('synced position (%s,%s) to movable (%s,%s) for %s', e.position.x, e.position.y, e.movable.x, e.movable.y, e.id)
  end
  if e.controllable then
    e.controllable.x = e.position.x
    e.controllable.y = e.position.y
    log(
      'synced position (%s,%s) to controllable (%s,%s) for %s',
      e.position.x,
      e.position.y,
      e.controllable.x,
      e.controllable.y,
      e.id
    )
  end
end

return PositionSyncSystem
