--------------------------------------------------------------------------------------------------------------
-- This is the statusbar, every widget, module and so on is combined to all the stuff you see on the screen --
--------------------------------------------------------------------------------------------------------------
-- Awesome Libs
local awful = require("awful")
local color = require("src.theme.colors")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")
local hidden = false

return function(s, widget)

    local top_center = awful.popup {
        screen = s,
        widget = wibox.container.background,
        ontop = false,
        bg = color["Background"],
        visible = true,
        maximum_width = dpi(800),
        placement = function(c) awful.placement.top(c, {
		margins = {dpi(6), dpi(6),dpi(0),dpi(6)}
	}) end,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5)
        end
    }

    top_center:setup {
        nil,
        {
            widget,
            margins = dpi(6),
            widget = wibox.container.margin
        },
        nil,
        forced_height = 50,
        layout = wibox.layout.align.horizontal
    }

    client.connect_signal(
        "manage",
        function(c)
            if #s.selected_tag:clients() < 1 or hidden then
                top_center.visible = false
            else
                top_center.visible = true
            end
        end
    )

    client.connect_signal(
        "unmanage",
        function(c)
            if #s.selected_tag:clients() < 1 or hidden then
                top_center.visible = false
            else
                top_center.visible = true
            end
        end
    )

    client.connect_signal(
        "tag::switched",
        function(c)
            if #s.selected_tag:clients() < 1 or hidden then
                top_center.visible = false
            else
                top_center.visible = true
            end
        end
    )

    awesome.connect_signal(
        "refresh",
        function(c)
            if #s.selected_tag:clients() < 1 or hidden then
                top_center.visible = false
            else
                top_center.visible = true
            end
        end
    )

    awesome.connect_signal(
	"(un)hide_wibar",
	function ()
		hidden = not hidden
	end
    )

end
