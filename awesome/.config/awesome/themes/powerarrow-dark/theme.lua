--[[

     Powerarrow Dark Awesome WM theme
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-dark"
theme.wallpaper                                 = theme.dir .. "/wall.jpg"
theme.font                                      = "Cascadia Code PL 11"
theme.fg_normal                                 = "#DDDDFF"
theme.fg_focus                                  = "#11A8CD"
theme.fg_urgent                                 = "#CC9393"
theme.bg_normal                                 = "#1A1A1A"
theme.bg_focus                                  = "#313131"
theme.bg_urgent                                 = "#1A1A1A"
theme.border_width                              = dpi(2)
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#11A8CD"
theme.border_marked                             = "#CC9393"
theme.tasklist_bg_focus                         = "#1A1A1A"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(140)
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = dpi(5)

local markup = lain.util.markup
local separators = lain.util.separators

local keyboardlayout = awful.widget.keyboardlayout:new()

-- Textclock
local clockicon = wibox.widget.textbox("🗓️")
local clock = awful.widget.watch(
    "date +'%a %d %b %R'", 60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { clock },
    notification_preset = {
        font = "Cascadia Code PL 10",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- MEM
--local memicon = wibox.widget.imagebox(theme.widget_mem)
local memicon = wibox.widget.textbox("🧠")
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
    end
})

-- CPU
local cpuicon = wibox.widget.textbox("🖥️")
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
    end
})

-- Coretemp
local tempicon = wibox.widget.textbox("🌡️")
local temp = lain.widget.temp({
    timeout = 2,
    tempfile = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/temp1_input", 
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
    end
})

-- Net
local neticon = wibox.widget.textbox("🌐")
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.font(theme.font,
                          markup("#2472C8", " " .. string.format("%06.1f", net_now.received))
                          .. " " ..
                          markup("#11A8CD", " " .. string.format("%06.1f", net_now.sent) .. " ")))
    end
})

-- Separators
local spr     = wibox.widget.textbox(' ')
local arrl_dl = separators.arrow_left(theme.bg_focus, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_focus)

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(18), bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            s.mytaglist,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            arrl_ld,
            wibox.container.background(keyboardlayout, theme.bg_focus),
            --keyboardlayout,
            --spr,
            arrl_dl,
            memicon,
            mem.widget,
            arrl_ld,
            wibox.container.background(cpuicon, theme.bg_focus),
            wibox.container.background(cpu.widget, theme.bg_focus),
            arrl_dl,
            tempicon,
            temp.widget,
            arrl_ld,
            wibox.container.background(neticon, theme.bg_focus),
            wibox.container.background(net.widget, theme.bg_focus),
            arrl_dl,
            clockicon,
            clock,
            spr,
            arrl_ld,
            wibox.container.background(s.mylayoutbox, theme.bg_focus),
        },
    }
end

return theme
