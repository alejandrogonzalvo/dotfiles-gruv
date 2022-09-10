-------------------------------------------------------------------------------------------------
-- This class contains rules for float exceptions or special themeing for certain applications --
-------------------------------------------------------------------------------------------------

-- Awesome Libs
local awful = require("awful")
local beautiful = require("beautiful")
local ruled = require("ruled")

awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = require("../../mappings/client_keys"),
            buttons = require("../../mappings/client_buttons"),
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },

    -- Solves Firefox buggy behaviour
    { rule = { class = "firefox" },
      properties = { opacity = 1, maximized = false, floating = false } },
      
    -- Solves Nautilus buggy behaviour
    { rule = { class = "Nautilus" },
      properties = { opacity = 1, maximized = false, floating = false } },

    { rule = { class = "mpv" },
      properties = {border_width = 0 }},

}

awful.spawn.easy_async_with_shell(
    "cat ~/.config/awesome/src/assets/rules.txt",
    function(stdout)
        for class in stdout:gmatch("%a+") do
            ruled.client.append_rule {
                rule = { class = class },
                properties = {
                    floating = true
                },
            }
        end
    end
)
