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
 
 local function startup1()
     term.clear()
     term.setTextColor(colors.yellow)
     term.setCursorPos(1,1)
     io.write("TurtApp Remote\n")
     term.setTextColor(colors.white)
     io.write("What is the turtles id:\n")
     id = tonumber(read())
     rednet.open("back")
     while true do
         local event, character = os.pullEvent("char")
         if character == "w" then
             rednet.send(id,"forward")
         end
         if character == "a" then
             rednet.send(id,"left")
         end
         if character == "s" then
             rednet.send(id,"back")
         end
         if character == "d" then
             rednet.send(id,"right")
         end
         if character == "q" then
             rednet.send(id,"down")
         end
         if character == "e" then
             rednet.send(id,"up")
         end
         if character == "z" then
             rednet.send(id,"dig")
         end
         if character == "x" then
             rednet.send(id,"place")
         end
         if character ==  "r" then
             rednet.send(id,"refuel")
         end
     end
 end
 local function startup2()
     term.clear()
     term.setTextColor(colors.yellow)
     term.setCursorPos(1,1)
     io.write("TurtApp Turtle\n")
     io.write("What side is the modem on:\n")
     side = read()
     io.write("\n")
     shell.run("id")
     io.write("\n")
     rednet.open(side)
     while true do
         local sender, message, protocol = rednet.receive()
         if message == "forward" then
             turtle.forward()
         end
         if message == "left" then
             turtle.turnLeft()
         end
         if message == "right" then
             turtle.turnRight()
         end
         if message == "back" then
             turtle.back()
         end
         if message == "up" then
         turtle.up()
         end
         if message == "down" then
             turtle.down()
         end
         if message == "dig" then
             turtle.dig()
         end
         if message == "place" then
             turtle.place()
         end
         if message == "refuel" then
             turtle.refuel()
         end
     end
 end
 local function startup3()
     term.clear()
     term.setTextColor(colors.yellow)
     term.setCursorPos(1,1)
     io.write("TurtApp\n")
     io.write("You can only use a Pocket Computer or Turtle with this!\n")
 end
 
 local dt = getDeviceType()
 if dt == "turtle" then
   startup2()
 elseif dt == "computer" or dt == "command_computer" then
   startup3()
 elseif dt == "pocket" then
   startup1()
 end