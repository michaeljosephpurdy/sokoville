---@class KeyboardState
local KeyboardState = {}

function KeyboardState:init()
  self.controls = {}
  self.released = {}
  return self
end

function KeyboardState:is_key_just_released(keycode)
  return self.released[keycode]
end

function KeyboardState:is_key_down(keycode)
  return love.keyboard.isDown(keycode)
end

function KeyboardState:push(keycode)
  self.controls[keycode] = true
end

function KeyboardState:release(keycode)
  self.controls[keycode] = false
  self.released[keycode] = true
end

function KeyboardState:clear_release(keycode)
  self.released[keycode] = false
end

function KeyboardState:reset()
  self.controls = {}
  self.released = {}
end

return KeyboardState
