-- ==========================================
-- PANEL TP + TOGGLE + RETURN FIX DEFINITIVO
-- ==========================================

if not game:IsLoaded() then
	game.Loaded:Wait()
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ===============================
-- TOGGLE GLOBAL
-- ===============================
if _G.PanelTP == nil then
	_G.PanelTP = false
end

_G.PanelTP = not _G.PanelTP
local ENABLED = _G.PanelTP

-- ===============================
-- LOADING (SIEMPRE)
-- ===============================
loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/davidsebas348-hub/Prompt-con-togle/refs/heads/main/OP_PARA_Prompt.lua",
	true
))()

-- ===============================
-- VARIABLES
-- ===============================
local PANEL_PARENT_NAME = "PanelSpawn"
local TELEPORT_OFFSET = Vector3.new(0, 3, 0)
local CHECK_DELAY = 0.01

-- 🔒 POSICIÓN INICIAL GLOBAL (CLAVE)
_G.PanelTP_StartCFrame = _G.PanelTP_StartCFrame or nil

-- ===============================
-- FUNCIONES
-- ===============================
local function getHRP()
	local char = player.Character or player.CharacterAdded:Wait()
	return char:WaitForChild("HumanoidRootPart")
end

local function getValidPanels()
	local panels = {}

	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Part")
			and obj.Parent
			and obj.Parent.Name == PANEL_PARENT_NAME then

			local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
			if prompt and prompt.Enabled then
				table.insert(panels, obj)
			end
		end
	end

	return panels
end

local function teleportTo(part)
	local hrp = getHRP()
	if part and part:IsDescendantOf(workspace) then
		hrp.CFrame = part.CFrame + TELEPORT_OFFSET
	end
end

-- ===============================
-- ACTIVAR
-- ===============================
if ENABLED then
	-- 🧠 guardar SOLO la primera vez
	if not _G.PanelTP_StartCFrame then
		_G.PanelTP_StartCFrame = getHRP().CFrame
	end

	task.spawn(function()
		local index = 1

		while _G.PanelTP do
			local panels = getValidPanels()

			if #panels > 0 then
				if index > #panels then
					index = 1
				end

				local target = panels[index]
				teleportTo(target)

				local prompt = target:FindFirstChildOfClass("ProximityPrompt")
				while _G.PanelTP and task.wait(0.2) do
					if not target:IsDescendantOf(workspace) then break end
					if not prompt or not prompt.Enabled then break end
				end

				index += 1
			end

			task.wait(CHECK_DELAY)
		end
	end)
end

-- ===============================
-- DESACTIVAR (VOLVER AL INICIO)
-- ===============================
if not ENABLED and _G.PanelTP_StartCFrame then
	getHRP().CFrame = _G.PanelTP_StartCFrame
	_G.PanelTP_StartCFrame = nil -- limpiar
end
