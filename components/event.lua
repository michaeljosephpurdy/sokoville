---@meta
---@class (exact) Event
---@field is_event boolean

---@class (exact) KeyPressEvent: Event
---@field key_press boolean
---@field keycode string

---@class (exact) KeyReleaseEvent: Event
---@field key_release boolean
---@field keycode string

---@class (exact) ScreenResizeEvent: Event
---@field screen_resize boolean
---@field width number
---@field height number

---@class (exact) LoadTileMapEvent: Event
---@field tile_map boolean
---@field level_id string

---@class (exact) SpawnEvent: Event
---@field spawn boolean
---@field position _PositionComponent

---@class (exact) RewindEvent: Event
---@field rewindable boolean

---@class (exact) GameStepAdvanceEvent: Event
---@field game_step_advance any
