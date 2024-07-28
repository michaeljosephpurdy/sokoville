local RewindPersistanceSystem = tiny.processingSystem()
local rewindable_entity_filter = tiny.requireAll('is_rewindable')
local tick_event_filter = tiny.requireAll('is_event', 'tick')
RewindPersistanceSystem.filter = tiny.requireAny(rewindable_entity_filter, tick_event_filter)

function RewindPersistanceSystem:initialize()
  self.should_process = false
end

function RewindPersistanceSystem:onAdd(e)
  -- event logic
  if e.is_event then
    RewindData:increment_rewind_step()
    self.should_process = true
    return
  end
  e.rewind_id = RewindData:setup_entity(e)
  RewindData:persist_data(e.rewind_id, {
    x = e.x,
    y = e.y,
  })
end

function RewindPersistanceSystem:onRemove(e)
  if e.is_event then
    self.should_process = false
  end
end

function RewindPersistanceSystem:process(e, dt)
  if e.is_event then
    return
  end
  if e.moved then
    logger:to_file('saving e.rewind_id')
    RewindData:persist_data(e.rewind_id, {
      x = e.x,
      y = e.y,
    })
  end
end

return RewindPersistanceSystem
