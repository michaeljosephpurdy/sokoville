---@class RewindData
local RewindData = class('RewindData')

function RewindData:initialize()
  self.rewind_data = {} -- TODO: check game save
  self.rewind_step = 1 -- TODO: check game save
  self.old_rewind_step = 1 -- TODO: check game save
end

---@param entity any
function RewindData:setup_entity(entity)
  local rewind_id = entity.rewind_id or love.math.random()
  self.rewind_data[rewind_id] = {}
  return rewind_id
end

---@param rewind_id string
---@return any
function RewindData:get_data(rewind_id)
  return self.rewind_data[rewind_id][self.rewind_step]
end

function RewindData:persist_data(rewind_id, data)
  self.rewind_data[rewind_id][self.rewind_step] = data
end

function RewindData:increment_rewind_step()
  self.rewind_step = self.rewind_step + 1
end

function RewindData:decrement_rewind_step()
  self.rewind_step = self.rewind_step - 1
  if self.rewind_step <= 1 then
    self.rewind_step = 1
  end
end

return RewindData
