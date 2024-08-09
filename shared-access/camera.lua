---@class CameraState
local CameraState = {}

function CameraState:init()
  self.x = 0
  self.y = 0
  self.xx = 0
  self.yy = 0
  self.scale = 1
  return self
end

function CameraState:set_screen_rect(x, y, xx, yy)
  self.x = x
  self.y = y
  self.xx = xx
  self.yy = yy
end

function CameraState:get_screen_rect()
  return self.x, self.y, self.xx, self.yy
end

return CameraState
