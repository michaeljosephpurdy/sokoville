local RewindPersistanceSystem = tiny.processingSystem()
local rewindable_entity_filter = tiny.requireAll('is_rewindable')
local tick_event_filter = tiny.requireAll('is_event', 'tick')
RewindPersistanceSystem.filter = tiny.requireAny(rewindable_entity_filter, tick_event_filter)

function RewindPersistanceSystem:initialize() end

function RewindPersistanceSystem:onAdd(e)
  -- event logic
  if e.is_event then
    GLOBAL.rewind_step = GLOBAL.rewind_step + 1
    self.should_process = true
    return
  end
  -- entity logic
  e.rewind_id = e.rewind_id or love.math.random()
  if not GLOBAL.rewind_data[e.rewind_id] then
    GLOBAL.rewind_data[e.rewind_id] = {}
  end
  -- persist
  GLOBAL.rewind_data[e.rewind_id][GLOBAL.rewind_step] = {
    x = e.x,
    y = e.y,
  }
  logger:to_file(GLOBAL.rewind_data[e.rewind_id])
end

function RewindPersistanceSystem:onRemove(e)
  if e.is_event then
    self.should_process = false
  end
end

function RewindPersistanceSystem:process(e, dt)
  if not self.should_process or e.is_event then
    return
  end

  -- get current step
  local step = GLOBAL.rewind_step

  -- save new data
  GLOBAL.rewind_data[e.rewind_id][step] = {
    x = e.x,
    y = e.y,
  }

  logger:to_screen('saving data for ' .. e.rewind_id .. ' during ' .. step)
  logger:to_file(GLOBAL.rewind_data[e.rewind_id])
end

return RewindPersistanceSystem
