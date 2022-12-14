-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
-- Load Debian menu entries

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
    properties = { border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  -- Spawn floating clients centered
  { rule_any = {floating = true},
    properties = {
      placement = awful.placement.centered,
      width = awful.screen.focused().workarea.width * 0.8,
      height = awful.screen.focused().workarea.height * 0.8
    }
  },

  -- Right opacity for kitty
  -- not functional
  -- { rule = {class = "kitty" },
  --   properties = { opacity = 1 }
  -- },

  -- Add titlebars to normal clients and dialogs
  -- { rule_any = {type = { "normal", "dialog" }
  --   }, properties = { titlebars_enabled = true }
  -- },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "1" }
  -- },
}
-- }}}
