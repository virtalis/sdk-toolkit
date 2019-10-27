local function generate(name)
  print("C / C++ Plugin Generator")
  print("Generating plugin: " .. name)
  -- Currently only generating CMakeLists

  local fsname = name:gsub("[%c%p%s]", "_"):lower()
  os.execute("mkdir " .. fsname)

  local cmakefile = fsname .. "/CMakeLists.txt"
  local f, err = io.open(cmakefile, "w")
  if not f then
    error(err)
  end

  f:write(string.format([=[# CMakeLists.txt
cmake_minimum_required(VERSION 2.8.11)

set(VRTREE_SDK_DIR "" CACHE STRING "Location of the VRTree SDK")

project(%s)

include_directories(${VRTREE_SDK_DIR}/include)
link_directories(${VRTREE_SDK_DIR}/lib/x64)

add_library(%s SHARED main.cpp)
target_link_libraries(%s vrtree-linker)]=], fsname, fsname, fsname))

  f:close()

  local cfile = fsname .. "/main.cpp"
  f, err = io.open(cfile, "w")
  if not f then
    error(err)
  end

  f:write(string.format([=[// main.cpp
#include <vrtree_api.h>

// Implement all of the standard API functions for api versioning, 
// and other hooks such as logging and progress displays
VRPLUGIN_API_IMPL;

PLUGIN_ENTRY_POINT const char* VRTREE_APIENTRY VRPName()
{
  return "%s";
}

PLUGIN_ENTRY_POINT const char* VRTREE_APIENTRY VRPVersion()
{
  return "1.0.0";
}

// Implement VRPInit to respond to application startup
PLUGIN_ENTRY_POINT int VRTREE_APIENTRY VRPInit()
{
  // load all of the VRTree C API functions. Note that a valid API license is required.
  VRPLUGIN_LOADVRTREE;

  // before using any of the hooks such as s_logFunc, it should be checked for null
  if(s_logFunc)
    s_logFunc(LOG_INFO, "Hello World!");

  return 0;
}

// Implement VRPCleanup to respond to unloading of the plugin
PLUGIN_ENTRY_POINT int VRTREE_APIENTRY VRPCleanup()
{
  return 0;
}

// Insert API license XML here
PLUGIN_ENTRY_POINT const char* VRTREE_APIENTRY VRPSignature()
{
  return "<VRTREE_API></VRTREE_API>";
}
  ]=], name:gsub("[\"]", "\\\"")))

  f:close()
end

return {
  generate = generate
}