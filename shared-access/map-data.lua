---@class MapData
local MapData = class('MapData') --[[@as MapData]]

function MapData:initialize()
  -- first, if the file does not exist, then we need to create it
  local file_exists = love.filesystem.getInfo('world.json')
  logger:to_file(file_exists)
  if not file_exists then
    logger:to_file('file does not exist')
    local initial_data = {
      tile_grid_data = TileGridData.data,
      entity_grid_data = EntityGridData.data,
    } --[[@as WorldData]]
    logger:to_file(TileGridData.data)
    love.filesystem.write('world.json', json.encode(initial_data))
  end
  local unparsed_world = love.filesystem.read('world.json')
  logger:to_file(unparsed_world)
  local data = json.decode(unparsed_world) --[[@as WorldData]]
  logger:to_file(data)
  self:persist(data)
end

function MapData:persist(world_data)
  local data = world_data --[[@as WorldData]]
  logger:to_file(data)
  local stringified_data = json.encode(data)
  logger:to_file(stringified_data)
  local success, error = love.filesystem.write('world.json', stringified_data)
  if error then
    assert(nil, error)
  end
  self.data = data
end

function MapData:load_from_file() end

function MapData:populate_world(tiny_world)
  TileGridData:load(self.data.tile_grid_data)
  EntityGridData:load(self.data.entity_grid_data)
  TileGridData:for_each(function(item)
    tiny_world:add(item)
  end)
  EntityGridData:for_each(function(item)
    tiny_world:add(item)
  end)
end

return MapData
