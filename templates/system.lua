local System = tiny.processingSystem()
local rejection_filter = tiny.rejectAll()
System.filter = tiny.requireAll(rejection_filter)

---@param props SystemProps
function System:init(props) end

---@param e any
function System:onAdd(e) end

---@param e any
function System:onRemove(e) end

---@param e any
---@param dt number
function System:process(e, dt) end

return System
