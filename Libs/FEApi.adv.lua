object. global 'FEApi' {
	AlignTypes = object {
		Align = 1, 
		CFrame = 2, 
		Weld = 3
	};
	HatManager = object {
		Character = nil;
		Hats = {};
		Aligns = {};
		FixHats = function(character: userdata): boolean
			local Hats: table = {}
			for i, v in pairs(character:GetChildren()) do
				if (v:IsA("Accessory")) then
					table.insert(Hats, v)
				end
			end
			for i, v in pairs(Hats) do
				for j, k in pairs(Hats) do
					if v ~= k and v.Name == k.Name then
						v.Name = v.Name .. tostring(i)
					end
				end
			end
			return true
		end;
		new = function(character: userdata, hats: table): table
			local self = table.new(FEApi.HatManager)
			self.Character = character
			self.Hats = hats
			return self
		end;
		set = function(self: table, character: userdata, hats: table): table
			self.Character = character or self.Character
			self.Hats = hats or self.Hats
			return self
		end;
		align = function(self: table): table
			self.Aligns = {}
			if (type(self.Character) ~= "userdata") then return end
			for i, v in pairs(self.Hats) do
				if (type(v) == "table" and
					type(v.Target) == "userdata" and
					type(v.Type) == "number") then
					if v.Type == FEApi.AlignTypes.Align then
						local Athp: userdata = Instance.new("Attachment", v.Target)
						local Atho: userdata = Instance.new("Attachment", v.Target)
						Athp.Name = "Attachment1"
						Atho.Name = "Attachment2"
						if v.Position ~= nil then Athp.Position = v.Position end
						if v.Rotation ~= nil then Atho.Rotation = v.Rotation end
						if v.Orientation ~= nil then Atho.Orientation = v.Orientation end
						self.Character:FindFirstChild(i):FindFirstChild("Handle"):FindFirstChildOfClass("AlignPosition").Attachment1 = Athp
						self.Character:FindFirstChild(i):FindFirstChild("Handle"):FindFirstChildOfClass("AlignOrientation").Attachment1 = Atho
						self.Aligns[i] = {
							Athp = Athp, 
							Atho = Atho,
						}
					end
				end
			end
			return self.Aligns
		end;
	}
}