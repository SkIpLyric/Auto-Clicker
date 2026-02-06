-- Auto Clicker Loader by SkLp
-- Version 1.0

print("=== Auto Clicker by SkLp ===")
print("Loading main script...")

-- Проверка на повторную загрузку
if _AUTOCLICKER_LOADED then
    print("Auto Clicker is already loaded!")
    return
end

_AUTOCLICKER_LOADED = true

-- Загрузка основного скрипта
local MainScriptUrl = "https://raw.githubusercontent.com/SkiPlyric/Auto-Clicker/main/main.lua"
local success, errorMessage = pcall(function()
    local script = loadstring(game:HttpGet(MainScriptUrl, true))()
    print("Auto Clicker loaded successfully!")
    return script
end)

if not success then
    warn("Loading failed: " .. tostring(errorMessage))
end

return true
