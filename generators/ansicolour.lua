local schar = string.char

local colormt = {}
local controls = {}

function colormt:__tostring()
    return self.value
end

function colormt:__concat(other)
    return tostring(self) .. tostring(other)
end

function colormt:__call(s)
    return self .. s .. controls.reset
end

colormt.__metatable = {}

local function makecolor(value)
    -- temporarily disabling ANSI colours until we can be smarter about whether it is supported. cmd.exe does not and it makes the options unreadable when using the included batch file.
    return setmetatable({ value = '' }, colormt) --schar(27) .. '[' .. tostring(value) .. 'm' }, colormt)
end

local colors = {
    -- attributes
    reset = 0,
    clear = 0,
    bright = 1,
    dim = 2,
    underscore = 4,
    blink = 5,
    reverse = 7,
    hidden = 8,

    -- foreground
    black = 30,
    red = 31,
    green = 32,
    yellow = 33,
    blue = 34,
    magenta = 35,
    cyan = 36,
    white = 37,

    -- background
    onblack = 40,
    onred = 41,
    ongreen = 42,
    onyellow = 43,
    onblue = 44,
    onmagenta = 45,
    oncyan = 46,
    onwhite = 47,
}

for c, v in pairs(colors) do
    controls[c] = makecolor(v)
end

return controls