loadstring((function()
local p=game:GetService("Players").LocalPlayer
local g=p:WaitForChild("PlayerGui")
local s=Instance.new("ScreenGui")
s.Name="AutoTPGui"
s.ResetOnSpawn=false
s.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
s.Parent=g
local f=Instance.new("Frame")
f.Size=UDim2.new(0,220,0,80)
f.Position=UDim2.new(0.5,-110,0,50)
f.BackgroundColor3=Color3.fromRGB(30,30,30)
f.BorderSizePixel=0
f.AnchorPoint=Vector2.new(0.5,0)
f.Parent=s
local c=Instance.new("UICorner")
c.CornerRadius=UDim.new(0,12)
c.Parent=f
local t=Instance.new("TextLabel")
t.Size=UDim2.new(1,-30,0,20)
t.Position=UDim2.new(0,5,0,0)
t.BackgroundTransparency=1
t.Text="AUTO COLLECT PANELS"
t.TextColor3=Color3.fromRGB(255,255,255)
t.Font=Enum.Font.SourceSansBold
t.TextSize=18
t.TextXAlignment=Enum.TextXAlignment.Left
t.Parent=f
local x=Instance.new("TextButton")
x.Size=UDim2.new(0,20,0,20)
x.Position=UDim2.new(1,-25,0,5)
x.Text="X"
x.TextColor3=Color3.fromRGB(255,255,255)
x.BackgroundColor3=Color3.fromRGB(200,0,0)
x.Font=Enum.Font.SourceSansBold
x.TextSize=16
x.ZIndex=999
x.Parent=f
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-20,0,50)
b.Position=UDim2.new(0,10,0,25)
b.Text="Activar AUTO TP + CLICK"
b.BackgroundColor3=Color3.fromRGB(0,170,255)
b.TextColor3=Color3.fromRGB(255,255,255)
b.Font=Enum.Font.SourceSansBold
b.TextSize=16
b.ZIndex=999
b.Parent=f
local u=game:GetService("UserInputService")
local d=false
local i,sPos,st
local function up(ip)
local delta=ip.Position-st
f.Position=UDim2.new(sPos.X.Scale,sPos.X.Offset+delta.X,sPos.Y.Scale,sPos.Y.Offset+delta.Y)
end
f.InputBegan:Connect(function(ip)
if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then
d=true
st=ip.Position
sPos=f.Position
ip.Changed:Connect(function()
if ip.UserInputState==Enum.UserInputState.End then d=false end
end)
end
end)
f.InputChanged:Connect(function(ip)
if ip.UserInputType==Enum.UserInputType.MouseMovement or ip.UserInputType==Enum.UserInputType.Touch then i=ip end
end)
u.InputChanged:Connect(function(ip) if ip==i and d then up(ip) end end)
local a=false
local thr
local scf
local function atp()
if not game:IsLoaded() then game.Loaded:Wait() end
local W=game:GetService("Workspace")
local V=game:GetService("VirtualInputManager")
local c=p.Character or p.CharacterAdded:Wait()
local hr=c:WaitForChild("HumanoidRootPart")
local cam=W.CurrentCamera
local ex={["Workspace.Lobby.airventExit.proxPart.ProximityPrompt"]=true,["Workspace.Exit.proxPart.ProximityPrompt"]=true,["Workspace.Lobby.maindoor.proxPart.ProximityPrompt"]=true}
local function fp(o)local pa=o.Name;local pr=o.Parent;while pr and pr~=W do pa=pr.Name.."."..pa;pr=pr.Parent end;return"Workspace."..pa end
local function ia(p) return p:IsA("ProximityPrompt") and p.Name~="RevivePrompt" and not ex[fp(p)] end
local function sp(p) if ia(p) then p.HoldDuration=0;p.RequiresLineOfSight=false;p.MaxActivationDistance=100;if p:FindFirstChild("Cooldown") then p.Cooldown.Value=0 end end end
for _,o in ipairs(W:GetDescendants()) do if o:IsA("ProximityPrompt") then sp(o) end end
W.DescendantAdded:Connect(function(o) if o:IsA("ProximityPrompt") then sp(o) end end)
local function tp(p) if p and p.Enabled then local sp,os=cam:WorldToViewportPoint(p.Parent.Position) if os then V:SendMouseButtonEvent(sp.X,sp.Y,0,true,cam,0) V:SendMouseButtonEvent(sp.X,sp.Y,0,false,cam,0) end end end
while a do
local cP
local sD=math.huge
for _,p in ipairs(W:GetDescendants()) do
if ia(p) and p.Enabled then
local dist=(hr.Position-p.Parent.Position).Magnitude
if dist<sD then sD=dist;cP=p end
end
end
if cP then local part=cP.Parent if part and part:IsA("BasePart") then hr.CFrame=CFrame.new(part.Position+Vector3.new(0,3,0)) task.wait(0.05) cam.CFrame=CFrame.new(cam.CFrame.Position,part.Position) while cP and cP.Enabled and a do tp(cP) task.wait(0.05) end end else task.wait(0.1) end
end
end
b.MouseButton1Click:Connect(function() a=not a if a then local c=p.Character or p.CharacterAdded:Wait() local hr=c:WaitForChild("HumanoidRootPart") scf=hr.CFrame b.Text="Detener AUTO COLLECT PANELS" thr=task.spawn(atp) else b.Text="Activar AUTO COLLECT PANELS" local c=p.Character if c and scf then local hr=c:FindFirstChild("HumanoidRootPart") if hr then hr.CFrame=scf end end end end)
x.MouseButton1Click:Connect(function() if a then a=false b.Text="Activar AUTO TP + CLICK" local c=p.Character if c and scf then local hr=c:FindFirstChild("HumanoidRootPart") if hr then hr.CFrame=scf end end end s:Destroy() end)
end)())
