-- {{{ Menu
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Layouts, widgets and utilities
local lain = require("lain")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
-- Load Debian menu entries
local dpi = require("beautiful.xresources").apply_dpi

-- Local Variable
local terminal = "kitty"
awful.util.terminal = terminal
local os = os

-- Locals needed for widgets
local wibar = {}
wibar.dir = os.getenv("HOME") .. '/.config/awesome/config/'
wibar.font = beautiful.font
wibar.widget_tile = wibar.dir .. '/icons/tile.png'
wibar.widget_ac = wibar.dir .. '/icons/ac.png'
wibar.widget_battery = wibar.dir .. '/icons/battery.png'
wibar.widget_battery_low = wibar.dir .. '/icons/battery_low.png'
wibar.widget_battery_empty = wibar.dir .. '/icons/battery_empty.png'
wibar.widget_mem = wibar.dir .. '/icons/mem.png'
wibar.widget_cpu = wibar.dir .. '/icons/cpu.png'
wibar.widget_temp = wibar.dir .. '/icons/temp.png'
wibar.widget_net = wibar.dir .. '/icons/net.png'
wibar.widget_hdd = wibar.dir .. '/icons/hdd.png'
wibar.widget_music = wibar.dir .. '/icons/music.png'
wibar.widget_music_on = wibar.dir .. '/icons/music_on.png'
wibar.widget_vol = wibar.dir .. '/icons/vol.png'
wibar.widget_vol_low = wibar.dir .. '/icons/vol_low.png'
wibar.widget_vol_no = wibar.dir .. '/icons/vol_no.png'
wibar.widget_vol_mute = wibar.dir .. '/icons/vol_mute.png'
wibar.widget_debian = wibar.dir .. '/icons/debian_linux_5242.png'

local markup = lain.util.markup
local separators = lain.util.separators

-- Debian Icon
local debianicon = wibox.widget.imagebox(wibar.widget_debian)

-- Textclock
local clock = awful.widget.watch(
  "date +'%a %d %b %R'", 60,
  function (widget, stdout)
    widget:set_markup(" " .. markup.font(wibar.font, stdout))
  end
)

-- Calender
wibar.cal = lain.widget.cal({
  attach_to = { clock },
  icons = "",
  week_number = "left",
  notification_preset = {
    font = "Hack Nerd Font 10",
    fg = beautiful.fg_normal,
    bg = beautiful.bg_normal
  }
})

-- MPD
-- local musicplr = awful.util.terminal .. " -title Music -e ncmcpp"
-- local mpdicon = wibox.widget.imagebox(wibar.widget_music)
-- mpdicon:buttons(my_table.join(
--   awful.button({ "Mod 4" }, 1, function () awful.spawn(musicplr) end),
--   awful.button({ }, 1, function ()
--     os.execute("mpc prev")
--     wibar.mpd.update()
--   end),
--   awful.button({ }, 2, function ()
--     os.execute("mpc toggle")
--     wibar.mpd.update()
--   end),
--   awful.button({ }, 3, function ()
--     os.execute("mpc next")
--     wibar.mpd.update()
--   end)
-- ))
-- wibar.mpd = lain.widget.mpd({
--   settings = function ()
--     if mpd_now.state == "play" then
--       artist = " " .. mpd_now.artist .. " "
--       title = mpd_now.title .. " "
--       mpdicon:set_image(wibar.widget_music_on)
--     elseif mpd_now.state == "pause" then
--       artist = " mpd "
--       title = "paused "
--     else
--       artist = ""
--       title = ""
--       mpdicon:set_image(wibar.widget_music)
--     end
--     widget:set_markup(markup.font(wibar.font, markup("#EA6F81", artist) .. title))
--   end
-- })

-- MEM
local memicon = wibox.widget.imagebox(wibar.widget_mem)
local mem = lain.widget.mem({
  settings = function ()
    widget:set_markup(markup.font(wibar.font, " " .. mem_now.used .. "MB "))
  end
})

-- CPU
local cpuicon = wibox.widget.imagebox(wibar.widget_cpu)
local cpu = lain.widget.cpu({
  settings = function ()
    widget:set_markup(markup.font(wibar.font, " " .. cpu_now.usage .. "% "))
  end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(wibar.widget_temp)
local temp = lain.widget.temp({
  settings = function ()
    widget:set_markup(markup.font(wibar.font, " " .. coretemp_now .. "°C "))
  end
})

-- Filesystem
local fsicon = wibox.widget.imagebox(wibar.widget_hdd)

-- Battery
local baticon = wibox.widget.imagebox(wibar.widget_battery)
local bat = lain.widget.bat({
  settings = function ()
    if bat_now.status and bat_now.status ~= "N/A" then
      if bat_now.ac_status == 1 then
        baticon:set_image(wibar.widget_ac)
      elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
        baticon:set_image(wibar.widget_battery_empty)
      elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
        baticon:set_image(wibar.widget_battery_low)
      else
        baticon:set_image(wibar.widget_battery)
      end
      widget:set_markup(markup.font(wibar.font, " " .. bat_now.perc .. "% "))
    else
      widget:set_markup(markup.font(wibar.font, " AC "))
      baticon:set_image(wibar.widget_ac)
    end
  end
})

-- Alsa Volume
local volicon = wibox.widget.imagebox(wibar.widget_vol)
wibar.volume = lain.widget.alsa({
  settings = function ()
    if volume_now.status == "off" then
      volicon:set_image(wibar.widget_vol_mute)
    elseif tonumber(volume_now.level) == 0 then
      volicon:set_image(wibar.widget_vol_no)
    elseif tonumber(volume_now.level) <= 50 then
      volicon:set_image(wibar.widget_vol_low)
    else
      volicon:set_image(wibar.widget_vol)
    end
    widget:set_markup(markup.font(wibar.font, " " .. volume_now.level .. "% "))
  end
})
wibar.volume.widget:buttons(awful.util.table.join(
  awful.button({}, 4, function ()
    awful.util.spawn("amixer set Master 1%+")
    wibar.volume.update()
  end),
  awful.button({}, 5, function ()
    awful.util.spawn("amixer set Master 1%-")
    wibar.volume.update()
  end)
))

-- Network Widget
local neticon = wibox.widget.imagebox(wibar.widget_net)
local net = lain.widget.net({
  settings = function ()
    widget:set_markup(markup.font(wibar.font, markup("#7AC82E", " " .. string.format("%06.1f", net_now.received))
      .. " " .. markup("#46A8C3", " " .. string.format("%06.1f", net_now.sent) .. " ")))
  end
})

-- Tile Icon
local tileicon = wibox.widget.imagebox(wibar.widget_tile)

-- Separators
local spr = wibox.widget.textbox(' ')
local arrr_dr = separators.arrow_right(beautiful.bg_focus, "alpha")
local arrr_rd = separators.arrow_right("alpha", beautiful.bg_focus)
local arrl_dl = separators.arrow_left(beautiful.bg_focus .. "aa", "alpha")
local arrl_ld = separators.arrow_left("alpha", beautiful.bg_focus .. "aa")

-- Wallpaper
local function set_wallpaper(s)
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, false)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  -- Create promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create taglist widget
  s.mytaglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.selected,
    buttons = awful.util.taglist_buttons,
  }

  -- Taglist widget template

  -- Create tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.focused,
    buttons = awful.util.tasklist_buttons,
    style = {
      border_width = dpi(2),
    },
    valign = "center",
    halign = "center",
    widget = wibox.container.place,
  }

  -- Create Wibox
  s.mywibox = awful.wibar({
    position = "top",
    screen = s,
    height = dpi(20),
    width = "99%",
    opacity = 0.9;
    border_width = dpi(5),
    bg = beautiful.bg_normal,
    fg = beautiful.fg_normal
  })

  -- Add widgets to wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { --Left Widgets
      layout = wibox.layout.fixed.horizontal,
      debianicon,
      arrr_rd,
      wibox.container.background(s.mytaglist, beautiful.bg_focus .. "aa"),
      arrr_dr,
      -- s.mypromptbox,
      spr,
    },
    { -- Middle Widgets
      layout = wibox.layout.align.horizontal,
      -- s.mytasklist,
      -- debianicon,
    },
    {
      layout = wibox.layout.fixed.horizontal,
      -- wibox.widget.systray(),
      spr,
      arrl_ld,
      wibox.container.background(memicon, beautiful.bg_focus .. "aa"),
      wibox.container.background(mem.widget, beautiful.bg_focus .. "aa"),
      arrl_dl,
      volicon,
      wibar.volume.widget,
      arrl_ld,
      wibox.container.background(cpuicon, beautiful.bg_focus .. "aa"),
      wibox.container.background(cpu.widget, beautiful.bg_focus .. "aa"),
      arrl_dl,
      tempicon,
      temp.widget,
      arrl_ld,
      wibox.container.background(fsicon, beautiful.bg_focus .. "aa"),
      arrl_dl,
      baticon,
      bat.widget,
      arrl_ld,
      wibox.container.background(neticon, beautiful.bg_focus .. "aa"),
      wibox.container.background(net.widget, beautiful.bg_focus .. "aa"),
      arrl_dl,
      clock,
      spr,
      arrl_ld,
      wibox.container.background(tileicon, beautiful.bg_focus .. "aa")
    }
  }
end)
