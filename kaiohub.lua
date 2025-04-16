repeat wait() until game:IsLoaded()

-- Criação da GUI
local gui = Instance.new("ScreenGui")
gui.Name = "Kaio Hub"
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Menu principal
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 250, 0, 350)
menuFrame.Position = UDim2.new(0, 20, 0, 100)
menuFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
menuFrame.Visible = false
menuFrame.Parent = gui

-- Botão para abrir/fechar o menu
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = gui
toggleButton.Size = UDim2.new(0, 100, 0, 50)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.Text = "Abrir Menu"
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 16

toggleButton.MouseButton1Click:Connect(function()
	menuFrame.Visible = not menuFrame.Visible
	toggleButton.Text = menuFrame.Visible and "Fechar Menu" or "Abrir Menu"
end)

-- Função para Teleport
local function teleport()
	local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
	char:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(1050, 360, 1400) -- Posicionamento
end

-- Função para pegar o inimigo mais próximo (Normal e Ossos)
local function getClosestEnemy(enemyList)
	local closest, dist = nil, math.huge
	for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
		if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
			for _, name in pairs(enemyList) do
				if string.find(v.Name, name) then
					local mag = (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
					if mag < dist then
						dist = mag
						closest = v
					end
				end
			end
		end
	end
	return closest
end

---------------------------------------------------
-- Botões da GUI
---------------------------------------------------

-- Auto Farm Normal
local autoFarmBtn = Instance.new("TextButton")
autoFarmBtn.Parent = menuFrame
autoFarmBtn.Size = UDim2.new(0, 200, 0, 50)
autoFarmBtn.Position = UDim2.new(0, 20, 0, 50)
autoFarmBtn.Text = "Auto Farm Normal"
autoFarmBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
autoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoFarmBtn.Font = Enum.Font.GothamBold
autoFarmBtn.TextSize = 16

local farming = false
autoFarmBtn.MouseButton1Click:Connect(function()
	farming = not farming
	autoFarmBtn.Text = farming and "Farmando..." or "Auto Farm Normal"
	while farming do
		local enemy = getClosestEnemy({"Reborn Skeleton", "Zombie"})
		if enemy then
			local char = game.Players.LocalPlayer.Character
			char.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
			local vim = game:GetService("VirtualInputManager")
			vim:SendMouseButtonEvent(0, 0, 0, true, game, 1)
			wait(0.1)
			vim:SendMouseButtonEvent(0, 0, 0, false, game, 1)
		end
		wait(0.2)
	end
end)

-- Auto Farm Ossos
local farmBoneBtn = Instance.new("TextButton")
farmBoneBtn.Parent = menuFrame
farmBoneBtn.Size = UDim2.new(0, 200, 0, 50)
farmBoneBtn.Position = UDim2.new(0, 20, 0, 110)
farmBoneBtn.Text = "Farm Ossos"
farmBoneBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
farmBoneBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
farmBoneBtn.Font = Enum.Font.GothamBold
farmBoneBtn.TextSize = 16

local farmBones = false
local boneEnemies = {"Reborn Skeleton", "Living Zombie", "Possessed Mummy", "Ghost Pirate", "Soul Reaper"}
farmBoneBtn.MouseButton1Click:Connect(function()
	farmBones = not farmBones
	farmBoneBtn.Text = farmBones and "Farmando Ossos..." or "Farm Ossos"
	while farmBones do
		local enemy = getClosestEnemy(boneEnemies)
		if enemy then
			local char = game.Players.LocalPlayer.Character
			char.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
			local vim = game:GetService("VirtualInputManager")
			vim:SendMouseButtonEvent(0, 0, 0, true, game, 1)
			wait(0.1)
			vim:SendMouseButtonEvent(0, 0, 0, false, game, 1)
		end
		wait(0.2)
	end
end)

-- Auto Girar Fruta
local autoSpinBtn = Instance.new("TextButton")
autoSpinBtn.Parent = menuFrame
autoSpinBtn.Size = UDim2.new(0, 200, 0, 50)
autoSpinBtn.Position = UDim2.new(0, 20, 0, 170)
autoSpinBtn.Text = "Auto Girar Fruta"
autoSpinBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
autoSpinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoSpinBtn.Font = Enum.Font.GothamBold
autoSpinBtn.TextSize = 16

local spinning = false
autoSpinBtn.MouseButton1Click:Connect(function()
	spinning = not spinning
	autoSpinBtn.Text = spinning and "Girando..." or "Auto Girar Fruta"
	while spinning do
		local fruitDealer = game:GetService("ReplicatedStorage"):WaitForChild("FruitDealer")
		fruitDealer:FindFirstChild("GachaSpin"):FireServer()
		wait(3600) -- Espera 1 hora para girar novamente
	end
end)

-- Coletar Frutas
local collectFruitBtn = Instance.new("TextButton")
collectFruitBtn.Parent = menuFrame
collectFruitBtn.Size = UDim2.new(0, 200, 0, 50)
collectFruitBtn.Position = UDim2.new(0, 20, 0, 230)
collectFruitBtn.Text = "Coletar Frutas"
collectFruitBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
collectFruitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
collectFruitBtn.Font = Enum.Font.GothamBold
collectFruitBtn.TextSize = 16

local collecting = false
collectFruitBtn.MouseButton1Click:Connect(function()
	collecting = not collecting
	collectFruitBtn.Text = collecting and "Coletando..." or "Coletar Frutas"
	while collecting do
		for _, v in pairs(game.Workspace:GetChildren()) do
			if v:IsA("Model") and v:FindFirstChild("Fruit") then
				local fruit = v:FindFirstChild("Fruit")
				if fruit then
					local char = game.Players.LocalPlayer.Character
					char.HumanoidRootPart.CFrame = fruit.CFrame
					wait(0.5)
				end
			end
		end
		wait(1)
	end
end)

-- Auto Guardar Frutas
local saveFruitBtn = Instance.new("TextButton")
saveFruitBtn.Parent = menuFrame
saveFruitBtn.Size = UDim2.new(0, 200, 0, 50)
saveFruitBtn.Position = UDim2.new(0, 20, 0, 290)
saveFruitBtn.Text = "Salvar Frutas"
saveFruitBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
saveFruitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
saveFruitBtn.Font = Enum.Font.GothamBold
saveFruitBtn.TextSize = 16

local saving = false
saveFruitBtn.MouseButton1Click:Connect(function()
	saving = not saving
	saveFruitBtn.Text = saving and "Salvando..." or "Salvar Frutas"
	while saving do
		local inventory = game.Players.LocalPlayer.Backpack
		for _, v in pairs(inventory:GetChildren()) do
			if v:IsA("Model") and v.Name == "Fruit" then
				local fruit = v:FindFirstChild("Fruit")
				-- Lógica para guardar a fruta automaticamente
				fruit.Parent = game.Players.LocalPlayer:FindFirstChild("Backpack")
				wait(0.5)
			end
		end
		wait(1)
	end
end)
