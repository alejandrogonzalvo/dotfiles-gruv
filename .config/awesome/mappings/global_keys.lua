-- Awesome Libs
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.autofocus")
local ruled = require("ruled")

local modkey = user_vars.modkey

return gears.table.join(
    awful.key(
        { modkey },
        "#39",
	function ()
		myscreen = awful.screen.focused()
		awesome.emit_signal("(un)hide_wibar")	
	end,
	{description = "toggle statusbar", group = "awesome"}
    ),
    -- Tag browsing
    awful.key(
        { modkey },
        "#113",
        awful.tag.viewprev,
        { description = "View previous tag", group = "Tag" }
    ),
    awful.key(
        { modkey },
        "#114",
        awful.tag.viewnext,
        { description = "View next tag", group = "Tag" }
    ),
    awful.key(
        { modkey },
        "#66",
        awful.tag.history.restore,
        { description = "Go back to last tag", group = "Tag" }
    ),
    awful.key(
        { modkey },
        "#44",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "Focus next client by index", group = "Client" }
    ),
    awful.key(
        { modkey },
        "#45",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "Focus previous client by index", group = "Client" }
    ),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    awful.key(
        { modkey },
        "#25",
        function()
            user_vars.main_menu:show()
        end,
        { description = "Show context menu", group = "Awesome" }
    ),
    awful.key(
        { modkey },
        "#36",
        function()
            awful.spawn(user_vars.terminal)
        end,
        { description = "Open terminal", group = "Applications" }
    ),
    awful.key(
        { modkey, "Control" },
        "#27",
        awesome.restart,
        { description = "Reload awesome", group = "Awesome" }
    ),
    awful.key(
        { modkey },
        "#46",
        function()
            awful.tag.incmwfact(0.05)
        end,
        { description = "Increase client width", group = "Layout" }
    ),
    awful.key(
        { modkey },
        "#43",
        function()
            awful.tag.incmwfact(-0.05)
        end,
        { description = "Decrease client width", group = "Layout" }
    ),
    awful.key(
        { modkey, "Control" },
        "#43",
        function()
            awful.tag.incncol(1, nil, true)
        end,
        { description = "Increase the number of columns", group = "Layout" }
    ),
    awful.key(
        { modkey, "Control" },
        "#46",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        { description = "Decrease the number of columns", group = "Layout" }
    ),
    awful.key(
        { modkey },
        "a",
        function()
            awful.layout.inc(-1)
        end,
        { description = "Select previous layout", group = "Layout" }
    ),
    awful.key(
        { modkey, "Shift" },
        "#36",
        function()
            awful.layout.inc(1)
        end,
        { description = "Select next layout", group = "Layout" }
    ),
    awful.key(
        { modkey },
        "#40",
        function()
            awful.spawn("/home/alejandro/.config/rofi/launchers/text/./launcher.sh")
        end,
        { descripton = "Application launcher", group = "Application" }
    ),
        -- Client moving
            awful.key({ modkey, "Shift" }, "Left",
              function ()
                -- get current tag
                local t = client.focus and client.focus.first_tag or nil
                if t == nil then
                    return
                end
                local pt = t.screen.tags[t.index-1]
                if pt == nil then
                  pt = t.screen.tags[4]
                end
                awful.client.movetotag(pt)
                awful.tag.viewprev()
              end,
            {description = "move client to previous tag and switch to it", group = "tag"}),

            awful.key({ modkey, "Shift" }, "Right",
              function ()
                -- get current tag
                local t = client.focus and client.focus.first_tag or nil
                if t == nil then
                    return
                end
                local nt = client.focus.screen.tags[t.index+1]
                if nt == nil then
                  nt = t.screen.tags[1]
                end
                awful.client.movetotag(nt)
                awful.tag.viewnext()
              end,
            {description = "move client to next tag and switch to it", group = "tag"}),

    awful.key(
        { modkey },
        "#26",
        function()
            awful.spawn(user_vars.file_manager)
        end,
        { descripton = "Open file manager", group = "System" }
    ),
    awful.key(
        {},
        "#107",
        function()
            awful.spawn(user_vars.screenshot_program)
        end,
        { description = "Screenshot", group = "Applications" }
    ),
    awful.key(
        {modkey},
        "o",
        function(c)
            awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ -2%", function()
                awesome.emit_signal("widget::volume")
                awesome.emit_signal("module::volume_osd:show", true)
                awesome.emit_signal("module::slider:update")
                awesome.emit_signal("widget::volume_osd:rerun")
            end)
        end,
        { description = "Lower volume", group = "System" }
    ),
    awful.key(
        {modkey},
        "p",
        function(c)
            awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ +2%", function()
                awesome.emit_signal("widget::volume")
                awesome.emit_signal("module::volume_osd:show", true)
                awesome.emit_signal("module::slider:update")
                awesome.emit_signal("widget::volume_osd:rerun")
            end)
        end,
        { description = "Increase volume", group = "System" }
    ),
    awful.key(
        {modkey},
        "m",
        function(c)
            awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
            awesome.emit_signal("widget::volume")
            awesome.emit_signal("module::volume_osd:show", true)
            awesome.emit_signal("module::slider:update")
            awesome.emit_signal("widget::volume_osd:rerun")
        end,
        { description = "Mute volume", group = "System" }
    ),
    awful.key(
        {modkey},
        "y",
        function(c)
            --awful.spawn("xbacklight -time 100 -inc 10%+")
            awful.spawn.easy_async_with_shell(
                "pkexec xfpm-power-backlight-helper --get-brightness",
                function(stdout)
                    awful.spawn.easy_async_with_shell("pkexec xfpm-power-backlight-helper --set-brightness " .. tostring(tonumber(stdout) + BACKLIGHT_SEPS), function(stdou2)

                    end)
                    awesome.emit_signal("module::brightness_osd:show", true)
                    awesome.emit_signal("module::brightness_slider:update")
                    awesome.emit_signal("widget::brightness_osd:rerun")
                end
            )
        end,
        { description = "Raise backlight brightness", group = "System" }
    ),
    awful.key(
        {modkey},
        "t",
        function(c)
            awful.spawn.easy_async_with_shell(
                "pkexec xfpm-power-backlight-helper --get-brightness",
                function(stdout)
                    awful.spawn.easy_async_with_shell("pkexec xfpm-power-backlight-helper --set-brightness " .. tostring(tonumber(stdout) - BACKLIGHT_SEPS), function(stdout2)

                    end)
                    awesome.emit_signal("module::brightness_osd:show", true)
                    awesome.emit_signal("module::brightness_slider:update")
                    awesome.emit_signal("widget::brightness_osd:rerun")
                end
            )
        end,
        { description = "Lower backlight brightness", group = "System" }
    ),
    awful.key(
        {modkey, "Shift"},
        "9",
        function(c)
            awful.spawn("playerctl play-pause")
        end,
        { description = "Play / Pause audio", group = "System" }
    ),
    awful.key(
        {modkey, "Shift"},
        "0",
        function(c)
            awful.spawn("playerctl next")
        end,
        { description = "Play / Pause audio", group = "System" }
    ),
    awful.key(
        {modkey, "Shift"},
        "8",
        function(c)
            awful.spawn("playerctl previous")
        end,
        { description = "Play / Pause audio", group = "System" }
    ),
    awful.key(
        { modkey },
        "=",
        function()
            awesome.emit_signal("kblayout::toggle")
        end,
        { description = "Toggle keyboard layout", group = "System" }
    ),
    awful.key(
        { modkey },
        "#22",
        function()
            awful.spawn.easy_async_with_shell(
                [[xprop | grep WM_CLASS | awk '{gsub(/"/, "", $4); print $4}']],
                function(stdout)
                    if stdout then
                        ruled.client.append_rule {
                            rule = { class = stdout:gsub("\n", "") },
                            properties = {
                                floating = true
                            },
                        }
                        awful.spawn.easy_async_with_shell(
                            "cat ~/.config/awesome/src/assets/rules.txt",
                            function(stdout2)
                                for class in stdout2:gmatch("%a+") do
                                    if class:match(stdout:gsub("\n", "")) then
                                        return
                                    end
                                end
                                awful.spawn.with_shell("echo -n '" .. stdout:gsub("\n", "") .. ";' >> ~/.config/awesome/src/assets/rules.txt")
                                local c = mouse.screen.selected_tag:clients()
                                for j, client in ipairs(c) do
                                    if client.class:match(stdout:gsub("\n", "")) then
                                        client.floating = true
                                    end
                                end
                            end
                        )
                    end
                end
            )
        end
    )
)
