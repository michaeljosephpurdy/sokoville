local MapEditorSystem = tiny.processingSystem()
MapEditorSystem.filter = tiny.requireAll()

function MapEditorSystem:initialize(props)
  self.keyboard_state = props.keyboard_state --[[@as KeyboardState]]
  self.mouse_state = props.mouse_state --[[@as MouseState]]
  self.map_data = props.map_data --[[@as MapData]]
  self.entity_factory = props.entity_factory --[[@as EntityFactory]]
  -- TODO load entity_grid_data from MapData
  self.entity_grid_data = EntityGridData
  -- TODO load tile_grid_data from MapData
  self.tile_grid_data = TileGridData
  ---@type EntityTypes | nil
  self.entity_to_place = nil
end

function MapEditorSystem:onAdd(e) end

function MapEditorSystem:onRemove(e) end

function MapEditorSystem:delete_entity()
  local entity = EntityGridData:get_data(self.cursor.x, self.cursor.y)
  if entity and not entity.is_player then
    self.world:remove(entity)
  end
  local tile = TileGridData:get_data(self.cursor.x, self.cursor.y)
  if tile then
    self.world:remove(tile)
  end
end

function MapEditorSystem:add_entity()
  if not self.entity_to_place then
    logger:to_file('do not know which type of entity to place')
    return
  end
  logger:to_file('left click at (' .. self.cursor.x .. ',' .. self.cursor.y .. ')')
  local entity = EntityGridData:get_data(self.cursor.x, self.cursor.y)
  -- don't do anything if this is same position as player
  if entity and entity.is_player then
    return
  end
  if entity then
    self.world:remove(entity)
  end
  local tile = TileGridData:get_data(self.cursor.x, self.cursor.y)
  if tile then
    self.world:remove(tile)
  end
  local new_entity = self.entity_factory:build(self.entity_to_place)
  new_entity.x = self.cursor.x
  new_entity.y = self.cursor.y
  self.world:add(new_entity)
end

function MapEditorSystem:toggle()
  self.should_process = not self.should_process
  if self.should_process then
    if not self.cursor then
      self.cursor = {
        x = 0,
        y = 0,
        width = GLOBAL.grid_size,
        height = GLOBAL.grid_size,
        draw_debug = true,
      }
      self.world:add(self.cursor)
    end
    EntityGridData:for_each(function(entity)
      tiny_world:remove(entity)
    end)
    TileGridData:for_each(function(entity)
      tiny_world:remove(entity)
    end)
    self.map_data:initialize()
    self.map_data:populate_world(tiny_world)
  else
    -- remove the cursor
    if self.cursor then
      self.world:removeEntity(self.cursor)
      self.cursor = nil
    end
    -- save data to map_data
    local new_data = {
      entity_grid_data = self.entity_grid_data.data,
      tile_grid_data = self.tile_grid_data.data,
    }--[[@as WorldData]]
    self.map_data:persist(new_data)
  end
end

function MapEditorSystem:update(dt)
  if self.keyboard_state:is_key_just_released('`') then
    self:toggle()
  elseif self.keyboard_state:is_key_just_released('p') then
    self.entity_to_place = self.entity_factory.types.PLAYER
  elseif self.keyboard_state:is_key_just_released('b') then
    self.entity_to_place = self.entity_factory.types.BOX
  end
  if not self.should_process then
    return
  end

  logger:to_screen('MAP EDITOR ACTIVE', 0)

  local old_x, old_y = self.cursor.x, self.cursor.y
  self.cursor.x, self.cursor.y = self.mouse_state:get_position_on_grid()
  local cursor_moved = old_x ~= self.cursor.x or old_y ~= self.cursor.y

  if self.mouse_state:is_right_click() then
    self:delete_entity()
  elseif self.mouse_state:is_left_click() then
    self:delete_entity()
    self:add_entity()
  end
end

return MapEditorSystem
