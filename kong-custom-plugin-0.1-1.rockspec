package = "kong-custom-plugin"

version = "0.1-1"     -- renumber, must match the info in the filename of this rockspec!
                      -- The version '0.1' is the source code version, the trailing '1' is the version of this rockspec.

-- supported_platforms = {"linux", "macosx"}

source = {
     url = "https://github.com/VaibhavG10/kong-custom-plugin.git"
  -- tag = "0.1-1"
}

description = {
  summary = "A Kong custom plugin, that shows basic implementation of kong plugin",
  license = "Apache 2.0"
}

dependencies = {
  "lua >= 5.1"
  -- If you depend on other rocks, add them here
}

-- local pluginName = "kong-custom-plugin"
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.kong-custom-plugin.handler"] = "src/handler.lua",
    ["kong.plugins.kong-custom-plugin.schema"] = "src/schema.lua"
  }
}
