local platformOne = script.Parent
local red = Color3.fromRGB(255, 0, 0)

local function onTouch(toucher)
	print("Someone (or something) touched PlatformOne")
	-- Other objects (non-Humanoid ones) can touch the platform as well
	-- This can occur even as a Player breaks apart (some Player "pieces" are non-humanoid)
	-- So, check if the object touching has a Parent and a Humanoid property
	-- If it DOES, we know it's a player.
	-- Only then, set the platform's Color to red 
	-- This avoids an error when Roblox can't find the .Humanoid property of whatever touched the platform.
	if toucher.Parent and toucher.Parent:FindFirstChild("Humanoid") then
		platformOne.Color = red
	end
end

platformOne.Touched:Connect(onTouch)