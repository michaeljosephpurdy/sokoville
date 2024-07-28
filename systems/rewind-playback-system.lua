local RewindPlaybackSystem = tiny.processingSystem()
local entity_filter = tiny.requireAll('is_rewindable')
local event_filter = tiny.requireAll('is_event', 'rewind')
RewindPlaybackSystem.filter = tiny.requireAny(entity_filter, event_filter)

function RewindPlaybackSystem:initialize()
  self.should_process = false
end

function RewindPlaybackSystem:onAdd(e)
  -- Decrement the rewind_step if this is a rewind event
  if e.is_event and e.rewind then
    RewindData:decrement_rewind_step()
    self.should_process = true
    return
  end
end

function RewindPlaybackSystem:onRemove(e)
  if e.is_event and e.rewind then
    self.should_process = false
  end
end

function RewindPlaybackSystem:process(e, dt)
  if not self.should_process or e.is_event then
    return
  end
  local entity_data = RewindData:get_data(e.rewind_id)
  if not entity_data then
    logger:to_file('no data for ' .. e.rewind_id)
    return
  end
  e.old_x = e.x
  e.old_y = e.y
  for k, v in pairs(entity_data) do
    e[k] = v
  end
  e.new_x = e.x
  e.new_y = e.y
  e.moved = true
end

return RewindPlaybackSystem
