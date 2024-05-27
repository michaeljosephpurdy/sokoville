local RewindPlaybackSystem = tiny.processingSystem()
local entity_filter = tiny.requireAll('is_rewindable')
local event_filter = tiny.requireAll('is_event', 'rewind')
RewindPlaybackSystem.filter = tiny.requireAny(entity_filter, event_filter)

function RewindPlaybackSystem:onAdd(e)
  -- Decrement the rewind_step if this is a rewind event
  if e.is_event and e.rewind then
    GLOBAL.rewind_step = GLOBAL.rewind_step - 1
    if GLOBAL.rewind_step <= 1 then
      GLOBAL.rewind_step = 1
    end
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
  local entity_data = GLOBAL.rewind_data[e.rewind_id][GLOBAL.rewind_step]
  if not entity_data then
    logger:to_file('nothing to rewind for ' .. e.rewind_id .. ' on ' .. GLOBAL.rewind_step)
    return
  end
  for k, v in pairs(entity_data) do
    e[k] = v
  end
end

return RewindPlaybackSystem
