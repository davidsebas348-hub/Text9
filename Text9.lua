do
    local _A,_B,_C,_D=string.char,string.byte,table.concat,math.random
    local _E=function(s)local t={}for i=1,#s do t[#t+1]=_A(_B(s,i)-3)end return _C(t)end
    local _F={"mrfduwvlkpi*jdpf","jrg0JhwVhuylfg","Soeb{huv","MrfdoSofbhu","ZdlwIruFjlop"}
    local _G={}
    for i,v in ipairs(_F) do _G[i]=_E(v) end
    local _ENV=(getfenv and getfenv()) or _ENV
    local S=_ENV[_G[2]](_ENV,_G[1])
    local P=S[_G[3]]
    local LP=P[_G[4]]
    local PG=LP[_G[5]](LP,_G[5])
    
    local function _junk()local x=0 for i=1,_D(3,9) do x=x+i*_D() end return x end

    local function _core()
        local Players=S:GetService("Players")
        local UIS=S:GetService("UserInputService")
        local plr=Players.LocalPlayer
        local gui=Instance.new("ScreenGui",plr:WaitForChild("PlayerGui"))
        gui.Name="__".._D(1000,9999)
        gui.ResetOnSpawn=false

        local f=Instance.new("Frame",gui)
        f.Size=UDim2.new(0,220,0,80)
        f.Position=UDim2.new(0.5,-110,0,50)
        f.BackgroundColor3=Color3.fromRGB(30,30,30)
        f.BorderSizePixel=0
        Instance.new("UICorner",f).CornerRadius=UDim.new(0,12)

        local t=Instance.new("TextLabel",f)
        t.Size=UDim2.new(1,-30,0,20)
        t.Position=UDim2.new(0,5,0,0)
        t.BackgroundTransparency=1
        t.Text="AUTO COLLECT PANELS"
        t.TextColor3=Color3.fromRGB(255,255,255)
        t.Font=Enum.Font.SourceSansBold
        t.TextSize=18
        t.TextXAlignment=Enum.TextXAlignment.Left

        local close=Instance.new("TextButton",f)
        close.Size=UDim2.new(0,20,0,20)
        close.Position=UDim2.new(1,-25,0,5)
        close.Text="X"
        close.TextColor3=Color3.fromRGB(255,255,255)
        close.BackgroundColor3=Color3.fromRGB(200,0,0)
        close.Font=Enum.Font.SourceSansBold
        close.TextSize=16
        close.ZIndex=999

        local b=Instance.new("TextButton",f)
        b.Size=UDim2.new(1,-20,0,50)
        b.Position=UDim2.new(0,10,0,25)
        b.Text="Activar AUTO TP + CLICK"
        b.BackgroundColor3=Color3.fromRGB(0,170,255)
        b.TextColor3=Color3.fromRGB(255,255,255)
        b.Font=Enum.Font.SourceSansBold
        b.TextSize=16
        b.ZIndex=999

        local drag,ds,sp=false,nil,nil
        f.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true ds=i.Position sp=f.Position end
            i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then drag=false end end)
        end)
        f.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseMovement and drag then local d=i.Position-ds f.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y) end end)
        UIS.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch and drag then local d=i.Position-ds f.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y) end end)

        local auto=false
        local startCFrame
        local function _tp()
            local W=S:GetService("Workspace")
            local V=S:GetService("VirtualInputManager")
            local char=plr.Character or plr.CharacterAdded:Wait()
            local hrp=char:WaitForChild("HumanoidRootPart")
            local cam=workspace.CurrentCamera

            local excludedPaths={
                ["Workspace.Lobby.airventExit.proxPart.ProximityPrompt"]=true,
                ["Workspace.Exit.proxPart.ProximityPrompt"]=true,
                ["Workspace.Lobby.maindoor.proxPart.ProximityPrompt"]=true
            }

            local function fullPath(o)local p=o.Name local pr=o.Parent while pr and pr~=W do p=pr.Name.."."..p pr=pr.Parent end return "Workspace."..p end
            local function allow(p) return p:IsA("ProximityPrompt") and p.Name~="RevivePrompt" and not excludedPaths[fullPath(p)] end
            local function setup(p) if allow(p) then p.HoldDuration=0 p.RequiresLineOfSight=false p.MaxActivationDistance=100 if p:FindFirstChild("Cooldown") then p.Cooldown.Value=0 end end end

            for _,obj in ipairs(W:GetDescendants()) do if obj:IsA("ProximityPrompt") then setup(obj) end end
            W.DescendantAdded:Connect(function(o) if o:IsA("ProximityPrompt") then setup(o) end end)

            local function trig(p) if p and p.Enabled then local sp,onS=cam:WorldToViewportPoint(p.Parent.Position) if onS then V:SendMouseButtonEvent(sp.X,sp.Y,0,true,cam,0) V:SendMouseButtonEvent(sp.X,sp.Y,0,false,cam,0) end end end

            while auto do
                local closest
                local shortest=math.huge
                for _,p in ipairs(W:GetDescendants()) do if allow(p) and p.Enabled then local d=(hrp.Position-p.Parent.Position).Magnitude if d<shortest then shortest=d closest=p end end end
                if closest then
                    local part=closest.Parent
                    if part:IsA("BasePart") then
                        hrp.CFrame=CFrame.new(part.Position+Vector3.new(0,3,0))
                        task.wait(0.05)
                        cam.CFrame=CFrame.new(cam.CFrame.Position,part.Position)
                        while closest and closest.Enabled and auto do trig(closest) task.wait(0.05) end
                    end
                else task.wait(0.1) end
            end
        end

        b.MouseButton1Click:Connect(function()
            auto=not auto
            if auto then
                local char=plr.Character or plr.CharacterAdded:Wait()
                startCFrame=char:WaitForChild("HumanoidRootPart").CFrame
                b.Text="Detener ".._junk()
                task.spawn(_tp)
            else
                b.Text="Activar AUTO TP + CLICK"
                local char=plr.Character
                if char and startCFrame then local h=char:FindFirstChild("HumanoidRootPart") if h then h.CFrame=startCFrame end end
            end
        end)

        close.MouseButton1Click:Connect(function()
            if auto then auto=false b.Text="Activar AUTO TP + CLICK" local char=plr.Character if char and startCFrame then local h=char:FindFirstChild("HumanoidRootPart") if h then h.CFrame=startCFrame end end end
            gui:Destroy()
        end)
    end

    _core()
end
