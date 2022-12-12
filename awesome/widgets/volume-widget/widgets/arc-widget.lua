local wibox = require("wibox")
local beautiful = require('beautiful')

local ICON_DIR = os.getenv("HOME") .. '/.config/awesome/widgets/volume-widget/icons/'

local widget = {}

function widget.get_widget(widgets_args)
  local args = widgets_args or {}

  local thickness = args.thickness or 2
  local main_color = beautiful.fg_focus
  local bg_color = beautiful.bg_normal
  local mute_color = beautiful.bg_normal
  local size = args.size or 18
  local font = args.font or beautiful.font

  return wibox.widget {
    {
      id = "icon",
      image = ICON_DIR .. 'audio-volume-high-symbolic.svg',
      resize = true,
      widget = wibox.widget.imagebox,
    },
    {
      id = 'txt',
      font = font,
      widget = wibox.widget.textbox
    },
    max_value = 100,
    thickness = thickness,
    start_angle = 4.71238898, -- 2pi*3/4
    forced_height = size,
    forced_width = size,
    bg = bg_color,
    paddings = 2,
    widget = wibox.container.arcchart,
    set_volume_level = function(self, new_value)
      self:get_children_by_id('txt')[1]:set_text(new_value)
      self.value = new_value
    end,
    mute = function(self)
      self.colors = { mute_color }
    end,
    unmute = function(self)
      self.colors = { main_color }
    end
  }
end

return widget
