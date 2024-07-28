---@class Global
local Global = {}
Global = class('Global')

function Global:initialize()
  self.game_width = 320 --640
  self.game_height = 180 --360
  self.border_color = { love.math.colorFromBytes(48, 44, 46) } --#302c2e
  self.refresh_world = false
end

return Global
