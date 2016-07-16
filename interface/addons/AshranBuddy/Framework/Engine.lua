local Engine, Api, Locale, Settings = unpack(AshranBuddy)

Engine.Modules = {}

-- Initialize the engine.
function Engine:OnInitialize()
	Settings:Initialize()

	-- Initialize all modules
	for name, module in pairs(self.Modules) do
		module:Initialize()
	end
end

-- Called when the addon is enabled.
function Engine:OnEnable()
	-- Enable modules
	for name, module in pairs(self.Modules) do
		local settings = Settings:Get(name)
		if settings.enabled then
			module:Enable()
		end
	end
end

-- Called when the addon is disabled.
function Engine:OnDisable()
	-- Disable modules
	for name, module in pairs(Engine.Modules) do
		module:Disable()
	end
end

-- Get an existing module instance.
function Engine:GetModule(name)
	return self.Modules[name]
end

-- Initializes and registers an engine module instance.
-- Optionally attach to an existing table instance.
function Engine:RegisterModule(name, instance)
	local module = instance or {}
	module.Name = name
	module.Enabled = false
	module.Component = CreateFrame("Frame", string.format("%s%sFrame", Engine.AddOnName, name))

	-- Register the module instance
	self.Modules[name] = module
	
	-- Activity registration
	module.Initialize = function(self)
		if type(self.OnInitialize) == "function" then
			self:OnInitialize()
		end
	end
	module.Enable = function(self)
		if not self.Enabled then
			self.Enabled = true
			if type(self.OnEnable) == "function" then
				self:OnEnable()
			end
		end
	end
	module.Disable = function(self)
		if self.Enabled then
			self.Enabled = false
			if type(self.OnDisable) == "function" then
				self:OnDisable()
			end
		end
	end
	
	-- Script registration
	module.Component.Scripts = {}
	module.RegisterScript = function(self, event, func)
		self.Component.Scripts[event] = func
		self.Component:SetScript(event, func)
	end
	module.UnregisterScript = function(self, event)
		self.Component.Scripts[event] = nil
		self.Component:SetScript(event, nil)
	end
	module.UnregisterAllScripts = function(self)
		for event = 1, #self.Component.Scripts do
			self.Component:SetScript(event, nil)
		end
		self.Component.Scripts = {}
	end

	-- Event registration
	module.Component.Events = {}
	module:RegisterScript("OnEvent", function(self, event, ...)
		local func = module.Component.Events[event]
		if type(module[func]) == "function" then
			module[func](module, event, ...)
		end
	end)
	module.RegisterEvent = function(self, event, func)
		self.Component.Events[event] = func or event
		self.Component:RegisterEvent(event)
	end
	module.UnregisterEvent = function(self, event)
		self.Component.Events[event] = nil
		self.Component:UnregisterEvent(event)
	end
	module.UnregisterAllEvents = function(self)
		self.Component.Events = {}
		self.Component:UnregisterAllEvents()
	end

	return module
end