local function install(url, path)
    local h = http.get(url).readAll()

    if h then
        f = fs.open(path, "w")
        f.write(h)
        f.close()
        print("Downloaded.")
    end
end

install("https://raw.githubusercontent.com/pTuxx/SwagSUS/main/startup.lua", "/startup.lua")
install("https://raw.githubusercontent.com/pTuxx/SwagSUS/main/programs/exit.lua", "/programs/exit.lua")

shell.run("rm /install.lua")
shell.run("reboot")