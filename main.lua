function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  class = require('plugins.middleclass')
  json = require('plugins.json')
  tiny = require('plugins.tiny')
  logger = require('logger')() --[[@as Logger]]
  RewindData = require('rewind-data')() --[[@as RewindData]]
  EntityGridData = require('grid-data')() --[[@as GridData]]
  TileGridData = require('grid-data')() --[[@as GridData]]
  GLOBAL = require('global')() --[[@as Global]]

  tiny_world = tiny.world()

  -- load systems
  -- load entities
  RewindEvent = require('entities.events.rewind')
  GameTickEvent = require('entities.events.game-tick')
  KeyPressEvent = require('entities.events.key-press')
  KeyReleaseEvent = require('entities.events.key-release')
  ScreenResizeEvent = require('entities.events.screen-resize')
  MapEditorToggleEvent = require('entities.events.map-editor-toggle')

  -- load shared-access
  -- these are used to access
  local mouse_state = require('shared-access.mouse')() --[[@as MouseState]]
  local keyboard_state = require('shared-access.keyboard')() --[[@as KeyboardState]]
  local joystick_state = require('shared-access.joystick')() --[[@as JoystickState]]
  local map_data = require('shared-access.map-data')() --[[@as MapData]]
  local entity_factory = require('shared-access.entity-factory')() --[[@as EntityFactory]]
  map_data:populate_world(tiny_world)

  for _, system in ipairs({
    require('systems.keyboard-state-system'),
    require('systems.mouse-state-system'),
    require('systems.joystick-state-system'),
    require('systems.map-editor-system'),
    require('systems.grid-based-collision-registration-system'),
    require('systems.player-input-system'),
    require('systems.grid-based-movement-system'),
    require('systems.rewind-persistance-system'),
    require('systems.rewind-playback-system'),
    require('systems.grid-based-collision-resolution-system'),
    require('systems.entity-movement-system'),

    require('systems.camera-system'),
    require('systems.background-sprite-drawing-system'),
    require('systems.sprite-drawing-system'),
    require('systems.foreground-sprite-drawing-system'),

    require('systems.debugger-overlay-system'),
    require('systems.singleton-manager-system'),
    require('systems.entity-cleanup-system'),
    require('systems.event-cleanup-system'),
  }) do
    if system.initialize then
      system:initialize({
        mouse_state = mouse_state,
        keyboard_state = keyboard_state,
        joystick_state = joystick_state,
        map_data = map_data,
        entity_factory = entity_factory,
      })
    end
    tiny_world:addSystem(system)
  end
end

function love.draw()
  local dt = love.timer.getDelta()
  tiny_world:update(dt)
  if GLOBAL.refresh_world then
    tiny_world:refresh()
    GLOBAL.refresh_world = false
  end
end

function love.keypressed(k)
  tiny_world:addEntity(KeyPressEvent(k))
end

function love.keyreleased(k)
  tiny_world:addEntity(KeyReleaseEvent(k))
end

function love.resize(w, h)
  tiny_world:addEntity(ScreenResizeEvent(w, h))
end
