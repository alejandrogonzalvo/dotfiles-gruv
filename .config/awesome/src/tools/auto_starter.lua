local awful = require("awful")

return function(table)
  for i, t in ipairs(table) do
    awful.spawn.with_shell(t);
  end

-- Hardcoding of static cava client
awful.spawn("kitty --config /home/alejandro/.config/kitty/trans_kitty.conf -e cava", {
	height = 200,
	width = 1920,
	border_width = 0,
	y = 880,
	floating = true,
	sticky = true,
	below=true,
	focusable=false,
	skip_taskbar=true,
})

-- Hardcoding of motviational phrase
awful.spawn("kitty --config /home/alejandro/.config/kitty/trans_kitty.conf -e motivate", {
	height = 400,
	width = 600,
	border_width = 0,
	y = 300,
	floating = true,
	sticky = true,
	below=true,
	focusable=false,
	skip_taskbar=true,
})

end
