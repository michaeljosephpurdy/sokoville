function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  tiny = require('plugins.tiny')
  json = require('plugins.json')
  tiny_world = tiny.world()
  peachy = require('plugins.peachy')

  ---@class SystemProps
  local props = {
    keyboard_state = require('shared-access.keyboard'):init(),
    camera_state = require('shared-access.camera'):init(),
    collision_grid = require('plugins.collision-grid').new(16, 1000, 100, function(e)
      return e.position.x, e.position.y
    end),
    game_width = 320, --640
    game_height = 180, --360
    game_border_color = { love.math.colorFromBytes(48, 44, 46) }, --#302c2e
    game_grid_size = 16,
    scale = 2,
    display_debug = false,
  }

  for _, system in ipairs({
    -- setup
    require('systems.tile-map-loading-system'),
    require('systems.entity-factory-system'),
    require('systems.collision-registration-system'),
    -- input
    require('systems.keyboard-state-system'),
    require('systems.controllable-system'),
    -- processing
    require('systems.movable-system'),
    require('systems.collision-detection-system'),
    require('systems.collision-resolution-system'),
    -- drawing
    require('systems.camera-system'),
    require('systems.sprite-drawing-system'),
    require('systems.debugger-overlay-system'),
    -- cleanup
    require('systems.perishable-system'),
    require('systems.event-cleanup-system'),
  }) do
    if system.init then
      system:init(props)
    end
    tiny_world:addSystem(system)
  end
  tiny_world:addEntity({
    is_event = true,
    level_id = 'Level_0',
    tile_map = true,
  } --[[@as LoadTileMapEvent]])
end

function love.update(dt)
  delta_time = dt
end

function love.draw()
  tiny_world:update(delta_time)
end

function love.keypressed(k)
  ---@type KeyPressEvent
  local key_press = { is_event = true, key_press = true, keycode = k }
  tiny_world:addEntity(key_press)
end

function love.keyreleased(k)
  ---@type KeyReleaseEvent
  local key_release = { is_event = true, key_release = true, keycode = k }
  tiny_world:addEntity(key_release)
end

function love.resize(w, h)
  ---@type ScreenResizeEvent
  local screen_resize_event = { is_event = true, screen_resize = true, width = w, height = h }
  tiny_world:addEntity(screen_resize_event)
end
