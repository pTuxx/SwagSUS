shell.run("cd /")
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
term.setCursorPos(1,2)