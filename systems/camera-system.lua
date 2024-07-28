local CameraSystem = tiny.processingSystem()
CameraSystem.filter = tiny.requireAny('camera_follow', 'screen_shake', 'resize')
CameraSystem.is_draw_system = true

function CameraSystem:initialize()
  self.push = require('plugins.push')
  local windowWidth, windowHeight = love.graphics.getDimensions()
  self.push:setupScreen(GLOBAL.game_width, GLOBAL.game_width, windowWidth, windowHeight, {
    fullscreen = false,
    resizable = true,
  })
  self.push:resize(windowWidth, windowHeight)
  self.push:setBorderColor(GLOBAL.border_color)
end

function CameraSystem:preWrap(dt)
  self.push:start()
end

function CameraSystem:postWrap(dt)
  self.push:finish()
end

function CameraSystem:onAdd(e)
  if e.resize and e.is_event then
    self.push:resize(e.width, e.height)
  end
end

function CameraSystem:process(e, dt)
  if e.camera_follow and e.x then
    love.graphics.translate(-e.x + self.game_width / 8, 0)
  end
  if e.screen_shake then
    local shake = love.math.newTransform()
    shake:translate(love.math.random(-e.magnitude, e.magnitude), love.math.random(-e.magnitude, e.magnitude))
    love.graphics.applyTransform(shake)
  end
end

return CameraSystem
