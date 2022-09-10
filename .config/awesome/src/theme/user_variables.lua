-------------------------------------------
-- Uservariables are stored in this file --
-------------------------------------------
local awful = require("awful")
local dpi = require("beautiful").xresources.apply_dpi
local home = os.getenv("HOME")

-- If you want different default programs, wallpaper path or modkey; edit this file.
user_vars = {

    -- Autotiling layouts
    layouts = {
        awful.layout.suit.tile,
        awful.layout.suit.floating,
    },

    -- Icon theme from /usr/share/icons
    icon_theme = "Papirus-Dark",

    -- Write the terminal command to start anything here
    autostart = {
        "picom --experimental-backends",
    },

    -- Type 'ip a' and check your wlan and ethernet name
    network = {
        wlan = "wlo1",
        ethernet = "eno1"
    },

    -- Set your font with this format:
    font = {
        regular = "Iosevka, 10",
        bold = "Iosevka, bold 10",
        extrabold = "Iosevka, ExtraBold 10"
    },

    -- This is your default Terminal
    terminal = "kitty",

    -- This is the modkey 'mod4' = Super/Mod/WindowsKey, 'mod3' = alt...
    modkey = "Mod4",

    -- place your wallpaper at this path with this name, you could also try to change the path
    wallpaper = home .. "/.config/awesome/src/assets/gruvbox_pixel.png",

    -- Naming scheme for the powermenu, userhost = "user@hostname", fullname = "Firstname Surname", something else ...
    namestyle = "userhost",

    -- List every Keyboard layout you use here comma seperated. (run localectl list-keymaps to list all averiable keymaps)
    kblayout = { "us", "es" },

    -- Your filemanager that opens with super+e
    file_manager = "nautilus",

    -- Screenshot program to make a screenshot when print is hit
    screenshot_program = "flameshot gui",
}
