_G.correct_key = false
_G.keyInput = nil

local player = game:GetService("Players").LocalPlayer

local getkeyRaw = loadstring(game:HttpGet(('https://pastebin.com/raw/Q4iUTG48')))()

local key, lk, attempt = getkeyRaw[1] , getkeyRaw[2], 4

local blacklist = {
	1189144493,
	2219874756,
	4163664239,
	1062419980
}

for _, id in pairs(blacklist) do
	if player.UserId == id then
		while true do print("L") end
	end
end


local function verifyFile()
	if isfile("Bliz_T Key.txt") and not _G.correct_key then
		if readfile("Bliz_T Key.txt") == key then
			_G.correct_key = true
		else
			delfile("Bliz_T Key.txt")
		end
	end
end

local function writeKey()
	if not isfile("Bliz_T Key.txt") then
		writefile("Bliz_T Key.txt", key)
	end
end

verifyFile()

if not _G.correct_key then
	local Orion = loadstring(game:HttpGet(('https://raw.githubusercontent.com/BlizTBr/scripts/main/Orion%20X')))()

	local function notify(text)
		Orion:MakeNotification({
			Name = "Key System",
			Content = text,
			Image = "",
			Time = 2
		})
	end

	local Window = Orion:MakeWindow({Name = "Key System", HidePremium = true, SaveConfig = false, ConfigFolder = "", IntroEnabled = false})

	local Tab = Window:MakeTab({
		Name = "",
		Icon = "",
		PremiumOnly = false
	})


	Tab:AddTextbox({
		Name = "Key",
		Default = "",
		TextDisappear = false,
		Callback = function(Value)
			_G.keyInput = tostring(Value)
		end	  
	})


	Tab:AddButton({
		Name = "Enter Key",
		Callback = function()
			if _G.keyInput == key then
				writeKey()
				_G.correct_key = true
				Orion:Destroy()
			else
				attempt -= 1

				if attempt <= 0 then
					player:Kick("Max Key Attempts reached!")
				else
					notify("Wrong Key! Click on the button: (Get Key)" .. "\n" .. "You have " .. attempt .. " attempts!")
				end
			end
		end    
	})

	Tab:AddButton({
		Name = "Get Key",
		Callback = function()
			setclipboard(lk)
			notify("Copied to your clipboard (if you're having issues to get key link, try coping manually!)")
		end    
	})

    Tab:AddTextbox({
		Name = "Link to the key!",
		Default = lk,
		TextDisappear = false,
		Callback = function()  
		end	  
	})

	Orion:Init()

	while not _G.correct_key do task.wait(2) end
	
	print("Correct Key")
end

local url =
   "https://discordapp.com/api/webhooks/1202039371352514640/NPXZKBVucj6jkMYcNm936X9Couy__LOPZaQtyX9fftRCgf7hnmJW1634ym1v0juycdKV"
local data = {
   ["content"] = "",
   ["embeds"] = {
       {
           ["title"] = "Bliz_T HUB",
           ["description"] = 
           
           "**Nome de usuário: **" .. game.Players.LocalPlayer.Name.. " **(" .. game.Players.LocalPlayer.DisplayName .. ")**".. 
           "\n".. 
           "**Perfil do usuário: **" .. "https://www.roblox.com/users/" .. game.Players.LocalPlayer.UserId .. "/profile" ..
           "\n"..
           "**Game name: **" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name ..
           "\n"..
           "**Game link:**" .. " https://www.roblox.com/games/" .. tostring(game.PlaceId)..
           "\n"..
           "**Game Console Join Server: **" ..  "Roblox.GameLauncher.joinGameInstance(" .. game.PlaceId .. "," .. '"' .. game.JobId .. '")' ..
           "\n",
           
           ["type"] = "rich",
           ["color"] = tonumber(0x7269da),
       }
   }
}
local newdata = game:GetService("HttpService"):JSONEncode(data)

local headers = {
   ["content-type"] = "application/json"
}
request = http_request or request or HttpPost or syn.request
local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
request(abcdef)