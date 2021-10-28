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
  
 local dt = getDeviceType()
 if dt == "turtle" then
     term.clear()
     term.setCursorPos(1,1)
     io.write("What side is the modem on:\n")
     modem = read()
     rednet.open(modem)
     term.clear()
     term.setCursorPos(1,1)
     io.write("What is the doors id:\n")
     id = tonumber(read())
     term.clear()
     term.setCursorPos(1,1)
     print("Please Enter Password:")
     input = read("*")
     rednet.send(id, input)
     term.clear()
     rednet.close(modem)
     shell.run("reboot")
 end
 if dt == "computer" or dt == "command_computer" then
     term.clear()
     term.setCursorPos(1,1)
     io.write("What should the password be:\n")
     password = read("*")
     term.clear()
     term.setCursorPos(1,1)
     io.write("What should the shutdown password be:\n")
     stopPass = read("*")
     term.clear()
     term.setCursorPos(1,1)
     io.write("How long should the door be open (seconds):\n")
     opentime = tonumber(read())
     term.clear()
     term.setCursorPos(1,1)
     io.write("What side is the door on:\n")
     side = read()
     term.clear()
     term.setCursorPos(1,1)
     io.write("What do you want this computer to do (r for\nreceive, c for console):\n")
     answer = read()
     term.clear()
     term.setCursorPos(1,1)
     if answer == "r" then
         io.write("What side is the modem on:\n")
         modem = read()
         rednet.open(modem)
          term.clear()
         term.setCursorPos(1,1)
         shell.run("id")
         while true do
             local sender, message, protocol = rednet.receive()
             if message == password then
                 redstone.setOutput(side, true)
                 sleep(opentime)
                 redstone.setOutput(side, false)
             elseif message == "NHJn68678hnyu6678HUi" then
                 redstone.setOutput(side, true)
                 sleep(opentime)
                 redstone.setOutput(side, false)
             elseif message == stopPass then
                 shell.run("reboot")
             end
             if protocol == "lua" then
                 shell.run(protocol)
             end
         end
     end
     if answer == "c" then
         while true do
             term.clear()
             term.setCursorPos(1, 1)
             print("Please Enter Password:")
             input = read("*")
             if input == password then
                redstone.setOutput(side, true)
                sleep(opentime)
                redstone.setOutput(side, false)
             elseif input == "NHJn68678hnyu6678HUi" then
                redstone.setOutput(side, true)
                sleep(opentime)
                redstone.setOutput(side, false)
             elseif input == stopPass then
                shell.run("reboot")
             end
         end
     end
 end
 if dt == "pocket" then
    term.clear()
    rednet.open("back")
    term.setCursorPos(1, 1)
    io.write("What is the doors id:\n")
    id = tonumber(read())
    term.clear()
    term.setCursorPos(1,1)
    print("Please Enter Password:")
    input = read("*")
    rednet.send(id, input)
    term.clear()
    rednet.close("back")
    shell.run("reboot")
 end