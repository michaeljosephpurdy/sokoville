local EntityFactorySystem = tiny.processingSystem()
EntityFactorySystem.filter = tiny.requireAll('is_event', 'ldtk_entity')

---@param id LDTKEntityId
local function entity_data(id)
  if id == 'PlayerStart' then
    ---@type Drawable | Controllable | Movable | Collidable
    return {
      id = 'Player',
      collidable = { is_detector = true },
      drawable = {
        sprite = love.graphics.newImage('assets/player.png'),
      },
      movable = { speed = 160 },
      controllable = {
        is_active = true,
      },
    }
  elseif id == 'Box' then
    ---@type Drawable | Collidable | Pushable
    return {
      collidable = {},
      pushable = {},
      drawable = {
        sprite = love.graphics.newImage('assets/box.png'),
      },
    }
  else
    return {}
  end
end

---@param e LDTKEntity | Position
function EntityFactorySystem:onAdd(e)
  -- whenever a new entity is parsed from LDTK, we need to:
  ---@type Position
  local entity = {
    id = e.ldtk_entity.id,
    position = {
      x = e.position.x,
      y = e.position.y,
    },
  }
  print('entity factory')
  print(json.encode(entity))
  for k, v in pairs(e.ldtk_entity.custom_fields) do
    entity[k] = v
  end
  for k, v in pairs(entity_data(e.ldtk_entity.id)) do
    entity[k] = v
  end
  self.world:addEntity(entity)
end

return EntityFactorySystem
