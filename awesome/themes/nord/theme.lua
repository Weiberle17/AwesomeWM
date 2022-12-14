-------------------------------
--  "Nord" awesome theme     --
--  by hmix adapted from     --
--  zenburn theme            --
--    By Adrian C. (anrxc)   --
-------------------------------

local themes_path = (require("gears.filesystem").get_configuration_dir() .. "themes/")
local dpi = require("beautiful.xresources").apply_dpi

-- {{{ Main
local theme = {}
theme.wallpaper = themes_path .. "nord/background.jpg"
-- }}}

-- {{{ Styles
-- theme.font      = "sans 8"
theme.font      = "Hack 9"

-- {{{ Colors
theme.fg_normal  = "#ECEFF4"
theme.fg_focus   = "#B48EAD"
theme.fg_urgent  = "#D08770"
theme.bg_normal  = "#2E3440"
theme.bg_focus   = "#3B4252"
theme.bg_urgent  = "#3B4252"
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.useless_gap   = dpi(5)
theme.border_width  = dpi(3.5)
theme.border_normal = "#3B4252"
theme.border_focus  = "#B48EAD"
theme.border_marked = "#D08770"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus   = "#3B4252"
theme.titlebar_bg_normal  = "#2E3440"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
-- Taglist Theme
theme.taglist_bg_focus = theme.bg_focus

-- Tasklist Theme
theme.tasklist_plain_task_name = false
theme.tasklist_disable_task_name = false
theme.tasklist_bg_focus = theme.bg_normal
theme.tasklist_disable_icon = false
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#A3BE8C"
--theme.fg_center_widget = "#8FBCBB"
--theme.fg_end_widget    = "#BF616A"
--theme.bg_widget        = "#434C5E"
--theme.border_widget    = "#3B4252"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#D08770"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)
-- }}}

-- {{{ Icons
-- {{{ Taglist
-- theme.taglist_squares_sel   = themes_path .. "nord/taglist/squarefz.png"
-- theme.taglist_squares_unsel = themes_path .. "nord/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = themes_path .. "nord/awesome-icon.png"
theme.menu_submenu_icon      = themes_path .. "default/submenu.png"
-- }}}

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
