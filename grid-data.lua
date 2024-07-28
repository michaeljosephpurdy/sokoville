---@class GridData
---@field grid_size number
local GridData = class('GridData') --[[@as GridData]]

---@private
function GridData:initialize()
  self.data = {}
  self.grid_size = 32
end

function GridData:load(data)
  self.data = {}
  for y, row in pairs(data) do
    if not self.data[y] then
      self.data[y] = {}
    end
    if row then
      for x, cell in pairs(row) do
        if cell then
          self.data[y][x] = cell
        end
      end
    end
  end
end

function GridData:dump_json()
  return json.encode(self.data)
end

function GridData:move_data(old_x, old_y, x, y, data)
  local previous = self:get_data(old_x, old_y)
  self:save_data(old_x, old_y, nil)
  self:save_data(x, y, data)
end

---@param _x number
---@param _y number
---@param data any
function GridData:save_data(_x, _y, data)
  local x, y = tostring(_x), tostring(_y)
  logger:to_file('saving at (' .. x .. ',' .. y .. ')')
  local row = self.data[y]
  if not row then
    self.data[y] = {}
  end
  self.data[y][x] = data
end

---@param _x number
---@param _y number
---@return any
function GridData:get_data(_x, _y)
  local x, y = tostring(_x), tostring(_y)
  local row = self.data[y]
  if not row then
    self.data[y] = {}
  end
  return self.data[y][x]
end

function GridData:for_each(fn)
  for _, row in pairs(self.data) do
    for _, cell in pairs(row) do
      if cell then
        fn(cell)
      end
    end
  end
end

return GridData
