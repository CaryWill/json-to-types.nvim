-- main module file
local module = require("json-to-types.module")
---@class Config
---@field opt string Your config option
local config = {}

---@class MyModule
local M = {}

---@type Config
M.config = config

---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.convertTypes = function(type)
  if type then
    return module.write_types(type)
  end
end
M.convertTypesBuffer = function(type)
  if type then
    return module.write_types_buffer(type)
  end
end
M.convertTypesCopy = function(type)
  if type then
    return module.write_types_copy_mode(type)
  end
end

return M
