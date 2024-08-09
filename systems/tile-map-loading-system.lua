local TileMapSystem = tiny.processingSystem()
TileMapSystem.filter = tiny.requireAll('is_event', 'tile_map')

function TileMapSystem:init(props)
  self.ldtk = require('plugins.super-simple-ldtk')
  self.ldtk:init('world')
  self.ldtk:load_all()
  self.on_image = function(image)
    ---@type Position | Drawable | Perishable
    local entity = {
      position = {
        x = image.x,
        y = image.y,
      },
      drawable = {
        sprite = love.graphics.newImage(image.image),
        z_index = -1,
      },
    }
    self.world:addEntity(entity)
  end
  self.on_tile = function(tile)
    if tile.value == 0 then
      return
    end
    ---@type Position | Collidable | Drawable
    local entity = {
      position = {
        x = tile.x,
        y = tile.y,
      },
      collidable = {
        is_solid = true,
      },
      drawable = {
        sprite = love.graphics.newImage('assets/solid.png'),
      },
    }
    self.world:addEntity(entity)
  end
  self.on_entity = function(e)
    print(json.encode(e))
    ---@type Event | Position | LDTKEntity | Perishable
    local entity = {
      is_event = true,
      position = {
        x = e.x,
        y = e.y,
      },
      ldtk_entity = {
        id = e.id,
        custom_fields = e.customFields,
      },
    }
    self.world:addEntity(entity)
  end
end

---@param e LoadTileMapEvent
function TileMapSystem:onAdd(e)
  self.ldtk:load(e.level_id, self.on_image, self.on_tile, self.on_entity)
end

return TileMapSystem
