# Visionary Render SDK Toolkit
Growing collection of utilities for simplifying tasks involving the Visionary Render SDK

## Install Instructions
1. Clone this repository
2. (optionally) Add the cloned directory to your PATH for easier command execution

## Visionary Render Plugin Generator
Currently only generates Lua plugins

### Run the generator
1. Open a command prompt in your Visionary Render plugins directory (e.g. `C:\Users\Documents\Visionary Render 2019.4\plugins` - create it if it does not exist)
2. Run `generate-plugin.bat`
3. Follow the instructions (the C / C++ Generator is not implemented yet)
4. The plugin will be generated in your plugins directory

## License
MIT

A compiled 64-bit version of LuaJIT 2.1.0-beta3 is included in `/bin` for use by the generator scripts. https://luajit.org/