--------------------------------------------------------------------------------------------------------------
-- This is the statusbar, every widget, module and so on is combined to all the stuff you see on the screen --
--------------------------------------------------------------------------------------------------------------
-- Awesome Libs
local awful = require("awful")
local color = require("src.theme.colors")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")

return function(s, widgets)

    local top_right = awful.popup {
        widget = wibox.container.background,
        ontop = false,
        bg = color["Background"],
        visible = true,
        screen = s,
        placement = function(c) awful.placement.top_right(c, { margins = {dpi(6), dpi(6),dpi(0),dpi(6)} }) end,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5)
        end
    }

    top_right:setup {
        nil,
        {
            {
                widgets[3],
                left = dpi(3),
                right = dpi(3),
                top = dpi(6),
                bottom = dpi(6),
                widget = wibox.container.margin
            },
            {
                widgets[4],
                left = dpi(3),
                right = dpi(3),
                top = dpi(6),
                bottom = dpi(6),
                widget = wibox.container.margin
            },
            {
                widgets[5],
                left = dpi(3),
                right = dpi(3),
                top = dpi(6),
                bottom = dpi(6),
                widget = wibox.container.margin
            },
            {
                widgets[6],
                left = dpi(3),
                right = dpi(3),
                top = dpi(6),
                bottom = dpi(6),
                widget = wibox.container.margin
            },
            {
                widgets[7],
                left = dpi(3),
                right = dpi(3),
                top = dpi(6),
                bottom = dpi(6),
                widget = wibox.container.margin
            },
            forced_height = 50,
            layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.align.horizontal,
	awesome.connect_signal(
	    "(un)hide_wibar",
	    function () 
		top_right.visible = not top_right.visible
	    end
	)
    }
end
