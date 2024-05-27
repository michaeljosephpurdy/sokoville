function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  class = require('plugins.middleclass')
  tiny = require('plugins.tiny')
  logger = require('logger')()

  tiny_world = tiny.world()

  -- load systems
  -- load entities
  RewindEvent = require('entities.events.rewind')
  GameTickEvent = require('entities.events.game-tick')
  KeyPressEvent = require('entities.events.key-press')
  KeyReleaseEvent = require('entities.events.key-release')
  ScreenResizeEvent = require('entities.events.screen-resize')

  ---@type SystemProps
  GLOBAL = {
    game_width = 320, --640,
    game_height = 180, --360,
    border_color = { love.math.colorFromBytes(48, 44, 46) }, --#302c2e
    grid_size = 32,
    rewind_data = {}, -- TODO: check game save
    rewind_step = 1, -- TODO: check game save
    old_rewind_step = 1, -- TODO: check game save
  }
  for _, system in ipairs({
    require('systems.event-cleanup-system'),
    require('systems.entity-cleanup-system'),
    require('systems.grid-based-collision-registration-system'),
    require('systems.player-input-system'),
    require('systems.entity-movement-system'),
    require('systems.grid-based-movement-system'),
    require('systems.rewind-persistance-system'),
    require('systems.rewind-playback-system'),
    require('systems.camera-system'),
    require('systems.background-sprite-drawing-system'),
    require('systems.sprite-drawing-system'),
    require('systems.foreground-sprite-drawing-system'),
    require('systems.debugger-overlay-system'),
  }) do
    if system.initialize then
      system:initialize()
    end
    tiny_world:addSystem(system)
  end
  tiny_world:add({
    x = 96,
    y = 32,
    dx = 0,
    dy = 0,
    snap_to_grid = true,
    is_pushable = true,
    --is_rewindable = true,
    sprite = love.graphics.newImage('assets/box.png'),
  })
  tiny_world:add({
    x = 32,
    y = 32,
    dx = 0,
    dy = 0,
    snap_to_grid = true,
    is_rewindable = true,
    is_player = true,
    sprite = love.graphics.newImage('assets/player.png'),
  })
end

function love.draw()
  local dt = love.timer.getDelta()
  tiny_world:update(dt)
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
