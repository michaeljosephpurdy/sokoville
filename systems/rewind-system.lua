local RewindSystem = tiny.processingSystem()

---@param e Rewindable
function RewindSystem:filter(e)
  return e.rewindable
end

---@param props SystemProps
function RewindSystem:init(props)
  self.system_props = props
  self.rewind = false
end

---@param e Rewindable | RewindEvent | Position
function RewindSystem:onAdd(e)
  if e.is_event then
    self.rewind = true
    return
  end
  print(string.format('RewindRewindSystem added %s', e.id))
  e.rewindable.previous = {
    [self.system_props.step] = { position = { x = e.position.x, y = e.position.y } },
  }
end

---@param e Rewindable | Position
function RewindSystem:onRemove(e) end

---@param e Rewindable | Position
---@param dt number
function RewindSystem:process(e, dt)
  if self.system_props.keyboard_state:is_key_just_released('space') then
    print('prep rewind')
    self.rewind = true
  end
  local current_positon = e.position
  local previous_position = e.rewindable.previous[self.system_props.step - 1]
  if not previous_position then
    return
  end
  if previous_position.x ~= current_positon.y and previous_position.y ~= current_positon.y then
    e.rewindable.previous[self.system_props.step] = {
      position = {
        x = current_positon.x,
        y = current_positon.y,
      },
    }
  end
  --if self.rewind then
  --self.rewind = false
  --end
end

---@param dt any
function RewindSystem:postWrap(dt)
  if not self.rewind then
    return
  end
  if self.system_props.step <= 1 then
    return
  end
  self.system_props.step = self.system_props.step - 1
  self.rewind = false
  ---@type table <number, Rewindable | Position>
  local entities = self.entities
  for _, entity in pairs(entities) do
    log('rewinding %s', entity.id)
    local previous_position = entity.rewindable.previous[self.system_props.step]
    log('current_position %s', json.encode(entity.position))
    log('previous_position %s', json.encode(previous_position))
    if previous_position then
      entity.position.x = previous_position.position.x
      entity.position.y = previous_position.position.y
    end
  end
end

return RewindSystem
