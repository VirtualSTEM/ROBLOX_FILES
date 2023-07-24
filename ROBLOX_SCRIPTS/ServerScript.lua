local platform_one = game.Workspace.PlatformOne
local platform_two = game.Workspace.PlatformTwo
local platform_three = game.Workspace.PlatformTwo

-- Produces 1, 2, or 3
local random_number = math.random(1, 3)
local trap = nil

if random_number == 1 then
	trap = platform_one
elseif random_number == 2 then
	trap = platform_two
elseif random_number == 3 then
	trap = platform_three
end

local function onTouch(toucher)
	print("Someone (or something) touched the trap")
	-- Destroy the object DOING the touching (a particular player)
	-- When a player breaks apart, other objects (non-Humanoid ones) will touch the platform as well
	-- So, check if the object touching has a Parent and a Humanoid property
	-- If it DOES, we know it's a player.
	-- Only then, set its Health to 0.  
	-- This avoids an error when Roblox can't find the .Humanoid property of whatever touched the platform.
	if toucher.Parent and toucher.Parent:FindFirstChild("Humanoid") then
		toucher.Parent.Humanoid.Health = 0 
	end
	
	-- Destroy the object BEING touched (the trap platform)
	trap:Destroy()
end

-- Connect the function to the Touched event
-- The function supplied to the Connect function is: onTouch
-- Therefore, the onTouch function is automatically supplied with
-- a parameter which represents the object 
trap.Touched:Connect(onTouch)

