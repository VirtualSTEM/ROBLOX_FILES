local checkpoint = script.Parent
local value = 0
print("Checkpoint Script Run: " .. value)
value = value + 1

function stepOnCheckpoint(toucher)
	print("Checkpoint Touched")
	
	if toucher.Parent and toucher.Parent:FindFirstChild('Humanoid') then
		local player = game.Players:GetPlayerFromCharacter(toucher.Parent)
		local checkpointDataFile = game.ServerStorage:FindFirstChild('CheckpointDataFile')
		
		if not checkpointDataFile then
			checkpointDataFile = Instance.new('Model', game.ServerStorage)
			checkpointDataFile.Name = 'CheckpointDataFile'
			-- If the checkpointDataFile doesn't exist, then it also doesn't have any entries
			-- Create an entry to store the new spawn point of the player who touched the Checkpoint part
			-- Give this entry a name: the name of the player (player.Name)
			Instance.new('ObjectValue', checkpointDataFile).Name = player.Name
		end
		
		-- Here, we know that the CheckpointDataFile exists and it has at least one entry for the player
		local savedCheckpoint = checkpointDataFile:FindFirstChild(player.Name)
		-- The player has touched this particular checkpoint, so the value of the entry should be that of this checkpoint Part
		savedCheckpoint.Value = checkpoint
		
		-- NOTE: this function definition is inside another function definition.
		-- It requires access to the savedCheckpoint variable
		local function goToCheckpoint(character)
			wait()
			local location = savedCheckpoint.Value.CFrame
			character:WaitForChild('HumanoidRootPart').CFrame = location + Vector3.new(0, 4, 0)
		end
		
		-- This line adds the goToCheckpoint callback function (above) to the event which occurs when
		-- a new character is created for a player
		-- This event handler is only added if for certain players who have touched this particular checkpoint block
		-- Once this handler is added, characters spawned later in the game will then go to this checkpoint object's location
		player.CharacterAdded:Connect(goToCheckpoint)
		
	end
end



checkpoint.Touched:Connect(stepOnCheckpoint)
