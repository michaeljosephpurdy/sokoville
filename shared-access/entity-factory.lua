---@class EntityFactory
local EntityFactory = class('EntityFactory') --[[@as EntityFactory]]
---@enum EntityTypes
local EntityTypes = {
  PLAYER = 0,
  BOX = 1,
}
EntityFactory.types = EntityTypes

---@private
---@type { [EntityTypes]: table }
EntityFactory.entities = {
  [EntityTypes.PLAYER] = {
    x = 1,
    y = 1,
    dx = 0,
    dy = 0,
    snap_to_grid = true,
    is_rewindable = true,
    is_player = true,
    draw_debug = true,
    sprite = 'assets/player.png',
  },
  [EntityTypes.BOX] = {
    x = 4,
    y = 1,
    dx = 0,
    dy = 0,
    snap_to_grid = true,
    is_rewindable = true,
    is_pushable = true,
    draw_debug = true,
    sprite = 'assets/box.png',
  },
}

---@param type EntityTypes
---@return table
function EntityFactory:build(type)
  local new_entity = {}
  for k, v in pairs(self.entities[type]) do
    new_entity[k] = v
  end
  return new_entity
end

return EntityFactory
