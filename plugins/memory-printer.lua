---@class (exact) MemoryPrinter
local MemoryPrinter = {}

---@param event string
function MemoryPrinter:log(event)
  print(string.format('%s - memory usage (%d bytes)', event, collectgarbage('count') * 1024))
end

return MemoryPrinter
