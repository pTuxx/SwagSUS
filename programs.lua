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
    print("SwagSUS 2.0 Pro")
    term.setTextColor(colors.white)
  else
    term.setCursorPos(1,1)
    print("SwagSUS 2.0")
  end
  if ctype == "turtle" or ctype == "computer" then
    term.setCursorPos(w-11,1)
  else
    term.setCursorPos(1,2)
  end
  if nOption == 1 then
    term.write("DoorLock")
  elseif nOption == 2 then
    term.write("RCTurtle")
  elseif nOption == 3 then
    term.write("Menu")
  else
  end
end

local function drawFrontend()
  local w,h = term.getSize()
  printCentered( math.floor(h/2) - 3, 0, "")
  printCentered( math.floor(h/2) - 2, 0, "Program Menu" )
  printCentered( math.floor(h/2) - 1, 0, "")
  printCentered( math.floor(h/2) + 0, 0, ((nOption == 1) and "[ DoorLock ]") or "DoorLock" )
  printCentered( math.floor(h/2) + 1, 0, ((nOption == 2) and "[ RCTurtle ]") or "RCTurtle" )
  printCentered( math.floor(h/2) + 3, 0, ((nOption == 3) and "[   Menu   ]") or "Menu" )
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
        if nOption < 3 then
          nOption = nOption + 1
          drawMenu()
          drawFrontend()
        end
      elseif key == 28 then
        if nOption  == 1 then
          shell.run("/programs/doorlock")
        elseif nOption == 2 then
          shell.run("/programs/rcturtle")
        elseif nOption == 3 then
          shell.run("/startup")
        else
        end
      end
    end
  end
  term.clear()
end

drawMenu()
drawFrontend()
startMenu()