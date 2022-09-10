-- Awesome Libs
local awful = require("awful")
local gears = require("gears")

local modkey = user_vars.modkey

return gears.table.join(
    awful.key(
        { modkey },
        "#41",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "Toggle fullscreen", group = "Client" }
    ),
    awful.key(
        { modkey },
        "#24",
        function(c)
            c:kill()
        end,
        { description = "Close focused client", group = "Client" }
    ),
    awful.key(
        { modkey },
        "#42",
        awful.client.floating.toggle,
        { description = "Toggle floating window", group = "Client" }
    ),
    awful.key(
        { modkey },
        "#58",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        { description = "(un)maximize", group = "Client" }
    ),
    awful.key(
        { modkey },
        "#57",
        function(c)
            if c == client.focus then
                c.minimized = true
            end
        end,
        { description = "minimize", group = "Client" }
    ),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"})

)
