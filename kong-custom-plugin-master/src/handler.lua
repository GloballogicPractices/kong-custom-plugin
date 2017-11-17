-- load the base plugin object
local BasePlugin = require "kong.plugins.base_plugin"

-- creating handler
local pluginhandler = BasePlugin:extend()
pluginhandler.PRIORITY = 3000

-- constructor
function pluginhandler:new()
  pluginhandler.super.new(self, "kong-custom-plugin")
  end

-- Main Logic
function pluginhandler:access(plugin_conf) -- Executed for every request upon it's reception from a client and before it is being proxied to the upstream service.
  pluginhandler.super.access(self)
  ngx.log(ngx.ERR, "Custom Plugin Execting")
end

return pluginhandler
