local function gitgrab(user, repo, branch, path)
  local h = http.get("https://raw.github.com/"..user.."/"..repo.."/"..branch.."/"..path).readAll()
  if h then
    return tostring(h())
  end
end

local function github(user, repo, branch, path, epath)
  local h = http.get("https://raw.github.com/"..user.."/"..repo.."/"..branch.."/"..path).readAll()
  
  if h then
    f = fs.open(epath, "w")
    f.write(h)
    f.close()
  end
end

local function read_file(path)
  local file = io.open(path, "rb")
  if not file then return nil end
  local content = file:read "*a"
  file:close()
  return content
end

local function getDeviceType()
    if turtle then
     return "turtle"
   elseif pocket then
     return "pocket"
   elseif commands then
     return "command_computer"
   else
     return "computer"
   end
 end
 
local function Install()
  if not fs.exists("versions/os_version.txt") or tonumber(read_file("versions/os_version.txt")) < tonumber(gitgrab("pTuxx", "SwagSUS", "main/versions", "os_version.txt")) then
    github("pTuxx", "SwagSUS", "main/versions", "os_version.txt", "versions/os_version.txt")
    github("pTuxx", "SwagSUS", "main", "startup.lua", "startup.lua")
    shell.run("reboot")
  end

  if not fs.exists("versions/doorlock_version.txt") or tonumber(read_file("versions/doorlock_version.txt")) < tonumber(gitgrab("pTuxx", "SwagSUS", "main/versions", "doorlock_version.txt")) then
    github("pTuxx", "SwagSUS", "main/versions", "doorlock_version.txt", "versions/doorlock_version.txt")
    github("pTuxx", "SwagSUS", "main/programs", "doorlock.lua", "programs/doorlock.lua")
  end

  if not fs.exists("versions/rcturtle_version.txt") or tonumber(read_file("versions/rcturtle_version.txt")) < tonumber(gitgrab("pTuxx", "SwagSUS", "main/versions", "rcturtle_version.txt")) then
    github("pTuxx", "SwagSUS", "main/versions", "rcturtle_version.txt", "versions/rcturtle_version.txt")
    github("pTuxx", "SwagSUS", "main/programs", "rcturtle.lua", "programs/rcturtle.lua")
  end
end
 
 local function startup1()
     if term.isColor() then
         term.clear()
         Install()
         term.setTextColor(colors.yellow)
         term.clear()
         term.setCursorPos(1,1)
         print("SwagSUS 1.0 Pro")
         term.setTextColor(colors.white)
         term.setCursorPos(1,2)
     else
        term.clear()
         Install()
         term.setCursorPos(1,1)
         print("SwagSUS 1.0")
         term.setCursorPos(1,2)
     end
 end
 
 local function startup2()
     if term.isColor() then
         term.clear()
         Install()
         term.setTextColor(colors.yellow)
         term.clear()
         term.setCursorPos(1,1)
         print("SwagSUS 1.0 Pro")
         term.setTextColor(colors.white)
         term.setCursorPos(1,2)
     else
         term.clear()
         Install()
         term.clear()
         term.setCursorPos(1,1)
         print("SwagSUS 1.0")
         term.setCursorPos(1,2)
     end
 end
 
 
 local dt = getDeviceType()
 if dt == "turtle" then
   startup2()
 elseif dt == "computer" or dt == "command_computer" then
   startup1()
 elseif dt == "pocket" then
   startup2()
 end