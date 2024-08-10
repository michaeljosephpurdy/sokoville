local System = tiny.processingSystem()

---@param e any
function System:filter(e)
  return e
end

---@param props SystemProps
function System:init(props)
  self.system_props = props
end

---@param world any
function System:onAddToWorld(world) end

---@param e any
function System:onAdd(e) end

---@param e any
function System:onAddEvent(e) end

---@param e any
function System:onRemove(e) end

---@param e any
function System:onRemoveEvent(e) end

---@param dt number
function System:preWrap(dt) end

---@param dt number
function System:preProcess(dt) end

---@param e any
---@param dt number
function System:process(e, dt) end

---@param dt number
function System:postProcess(dt) end

---@param dt number
function System:postWrap(dt) end

---@param world any
function System:onRemoveFromWorld(world) end

return System
