local scriptDir = string.match(arg[0], "(.-)([^\\]-([^%.]+))$")
package.path = scriptDir .. "/?.lua;" .. package.path

local colour = require("ansicolour")
local luaplugin = require("luaplugin")

local options = {
  type = { "Lua Plugin", "C / C++ Plugin" },
  type_spec = {
    nil, 
    { "Visual Studio 2017", "CMake" }
  }
}

local steps = {
  {
    field = "Plugin Type",
    caption = "Which type of plugin do you want?",
    type = "option",
    options = options.type
  },
  {
    field = "Build System",
    caption = "Choose build system",
    type = "option",
    options = options.type_spec,
    cond_prev = true
  },
  {
    field = "Name",
    caption = "Enter a name for the plugin",
    type = "input"
  }
}

local currentStep = 1
local stepInput = {}
local stepInputCaptions = {}

print(colour.blue("Visionary Render Plugin Generator"))

while currentStep <= #steps do
  local step = steps[currentStep]
  if step.type == "option" then
    local opt = step.options
    if opt and step.cond_prev then
      opt = opt[stepInput[currentStep - 1]]
    end
    if not opt then
      currentStep = currentStep + 1
    else
      print(step.caption)
      for i, v in ipairs(opt) do
        print(colour.green(i .. ": " .. v))
      end
      print("Enter a number:")
      local sel = tonumber(io.read())
      if not sel or sel > #opt then
        print(colour.red("Invalid option"))
      else
        stepInput[currentStep] = sel
        stepInputCaptions[currentStep] = opt[sel]
        currentStep = currentStep + 1
      end
    end
  elseif step.type == "input" then
    print(step.caption)
    local input = io.read()
    if string.len(input) == 0 then
      print(colour.red("Input is required"))
    else
      stepInput[currentStep] = input
      currentStep = currentStep + 1
    end
  else
    error("Unrecognised step type: " .. step.type)
  end
end

print(colour.green("Generating the following plugin:"))
for k, v in pairs(stepInput) do
  print("  " .. colour.yellow .. steps[k].field .. ": " .. colour.reset .. (stepInputCaptions[k] or v))
end

if stepInput[1] == 1 then
  luaplugin.generate(stepInput[3])
elseif stepInput[1] == 2 then
  --cplugin.generate(stepInput[3], stepInput[2])
end