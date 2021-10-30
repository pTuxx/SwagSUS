shell.run("cd /")
term.clear()
term.setCursorPos(1,1)
if term.isColor() then
    term.setTextColor(colors.yellow)
    term.setCursorPos(1,1)
    print("SwagSUS 1.0 Pro")
    term.setCursorPos(1,3)
    print("> ")
    term.setTextColor(colors.white)
else
    term.setCursorPos(1,1)
    print("SwagSUS 1.0")
    term.setCursorPos(1,3)
    print("> ")
end
local x, y = term.getCursorPos()
x = x - 1
y = y + 1
term.setCursorPos(x,y
while true do
    cmd = read()
    if cmd == "menu" then
        shell.run("/startup")
    else
        shell.run(cmd)
    end
    if term.isColor() then
        term.setTextColor(colors.yellow)
        print("\n> ")
        term.setTextColor(colors.white)
    else
        print("\n> ")
    end
    local x, y = term.getCursorPos()
    x = x - 1
    y = y + 1
    term.setCursorPos(x,y)
end