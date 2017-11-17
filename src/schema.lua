return {
  -- no_consumer: If true, it will not be possible to apply this plugin to a specific Consumer. This plugin must be API-wide only. For example: authentication plugins
    no_consumer = true,
  -- Fields: plugin's schema. A key/value table of available properties and their rules.
    fields = {
      Field1 = {type = "string", required = true},
      Field2 = {type = "string", required = true}
    },
  -- self_check: A function to implement if someone want to perform any custom validation before accepting the plugin's configuration.
    self_check = function(schema, plugin_t, dao, is_updating)
      -- perform any custom verification
      return true
    end
}
