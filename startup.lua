local nOption = 1

function printCentered( y, xoff, s )
  local w,h = term.getSize()
  local x = math.floor((w - string.len(s)) / 2)
  x = x + xoff
  term.setCursorPos(x,y)
  term.clearLine()
  term.write( s )
end

local function drawMenu()
  local w,h = term.getSize()
  term.clear()
  term.setCursorPos(1,1)
  if term.isColor() then
    term.setTextColor(colors.yellow)
    term.setCursorPos(1,1)
    print("SwagSUS 1.0 Pro")
    term.setTextColor(colors.white)
  else
    term.setCursorPos(1,1)
    print("SwagSUS 1.0")
  end
  term.setCursorPos(w-11,1)
  if nOption == 1 then
    term.write("Command")
  elseif nOption == 2 then
    term.write("Programs")
  elseif nOption == 3 then
    term.write("Shutdown")
  elseif nOption == 4 then
    term.write("Uninstall")
  else
  end
end

local function drawFrontend()
  local w,h = term.getSize()
  printCentered( math.floor(h/2) - 3, 0, "")
  printCentered( math.floor(h/2) - 2, 0, "Start Menu" )
  printCentered( math.floor(h/2) - 1, 0, "")
  printCentered( math.floor(h/2) + 0, -1, ((nOption == 1) and " [ Command  ]") or "Command" )
  printCentered( math.floor(h/2) + 1, 0, ((nOption == 2) and "[ Programs ]") or "Programs" )
  printCentered( math.floor(h/2) + 2, 0, ((nOption == 3) and "[ Shutdown ]") or "Shutdown" )
  printCentered( math.floor(h/2) + 3, 0, ((nOption == 4) and "[ Reboot   ]") or "Reboot" )
  printCentered( math.floor(h/2) + 4, 0, "")
end

local function startMenu()
  while true do
    local e,p = os.pullEvent()
    if e == "key" then
      local key = p
      if key == 17 or key == 200 then
        if nOption > 1 then
          nOption = nOption - 1
          drawMenu()
          drawFrontend()
        end
      elseif key == 31 or key == 208 then
        if nOption < 4 then
          nOption = nOption + 1
          drawMenu()
          drawFrontend()
        end
      elseif key == 28 then
        if nOption  == 1 then
          shell.run("/command")
        elseif nOption == 2 then
          shell.run("/programs")
        elseif nOption == 3 then
          os.shutdown()
        else
          os.reboot()
        end
      end
    end
  end
  term.clear()
end

function split(pString, pPattern)
  local Table = {}
  local fpat = "(.-)" .. pPattern
  local last_end = 1
  local s, e, cap = pString:find(fpat, 1)
  while s do
     if s ~= 1 or cap ~= "" then
    table.insert(Table,cap)
     end
     last_end = e+1
     s, e, cap = pString:find(fpat, last_end)
  end
  if last_end <= #pString then
     cap = pString:sub(last_end)
     table.insert(Table, cap)
  end
  return Table
end

local function gitgrab(user, repo, branch, path)
  local h = http.get("https://raw.github.com/"..user.."/"..repo.."/"..branch.."/"..path).readAll()
  if h then
    return h
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
    github("pTuxx", "SwagSUS", "main/versions", "os_version.txt", "/versions/os_version.txt")
    github("pTuxx", "SwagSUS", "main", "startup.lua", "/startup.lua")
    shell.run("reboot")
  end

  if not fs.exists("versions/doorlock_version.txt") or tonumber(read_file("versions/doorlock_version.txt")) < tonumber(gitgrab("pTuxx", "SwagSUS", "main/versions", "doorlock_version.txt")) then
    github("pTuxx", "SwagSUS", "main/versions", "doorlock_version.txt", "/versions/doorlock_version.txt")
    github("pTuxx", "SwagSUS", "main/programs", "doorlock.lua", "/programs/doorlock.lua")
  end

  if not fs.exists("versions/rcturtle_version.txt") or tonumber(read_file("versions/rcturtle_version.txt")) < tonumber(gitgrab("pTuxx", "SwagSUS", "main/versions", "rcturtle_version.txt")) then
    github("pTuxx", "SwagSUS", "main/versions", "rcturtle_version.txt", "/versions/rcturtle_version.txt")
    github("pTuxx", "SwagSUS", "main/programs", "rcturtle.lua", "/programs/rcturtle.lua")
  end
end

Install()
drawMenu()
drawFrontend()
startMenu()