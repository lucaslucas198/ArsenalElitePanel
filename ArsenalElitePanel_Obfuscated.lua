local _s=string.char
local _q1=game:GetService(_s(80,108,97,121,101,114,115))
local _q2=game:GetService(_s(82,117,110,83,101,114,118,105,99,101))
local _q3=game:GetService(_s(85,115,101,114,73,110,112,117,116,83,101,114,118,105,99,101))
local _q4=game:GetService(_s(84,119,101,101,110,83,101,114,118,105,99,101))
local _q5=game:GetService(_s(76,105,103,104,116,105,110,103))
local _q6=game:GetService(_s(82,101,112,108,105,99,97,116,101,100,83,116,111,114,97,103,101))
local _q7=game:GetService(_s(87,111,114,107,115,112,97,99,101))
local _q8=_q1.LocalPlayer
local _q9=_q7.CurrentCamera or _q7:FindFirstChildOfClass(_s(67,97,109,101,114,97))
local _qa={[_q8.UserId]=true}
if game.CreatorType==Enum.CreatorType.User and game.CreatorId~=_q8.UserId and not _qa[_q8.UserId] then return end
local _qb=false
local _qc=false
local _qd=_s(83,72,66,45,65,69,80,50,45,88,55,75,52)
local _qe=_s(65,69,80,95,75,101,121,46,116,120,116)
local _qf=_s(65,69,80,95,69,120,112)
local _q10={Connections={},Original={WalkSpeed=16,JumpPower=50,Gravity=_q7.Gravity,FieldOfView=_q9 and _q9.FieldOfView or 70,Lighting={FogEnd=_q5.FogEnd,FogStart=_q5.FogStart,Brightness=_q5.Brightness,ClockTime=_q5.ClockTime,Ambient=_q5.Ambient,GlobalShadows=_q5.GlobalShadows}},Config={SpeedEnabled=false,WalkSpeed=24,JumpEnabled=false,JumpPower=75,InfiniteJump=false,Fly=false,FlySpeed=55,Noclip=false,Fullbright=false,RemoveFog=false,RemoveShadows=false,Time=14,Gravity=_q7.Gravity,CameraFOV=70,RecoilReduction=0,SpreadReduction=0,RapidFire=false,InfiniteAmmo=false,AutoReload=false,AutoRespawn=false,AutoHeal=false,LowGraphics=false}}
local function _q11(_r1,_r2,_r3)
if _q10.Connections[_r1] then _q10.Connections[_r1]:Disconnect() end
_q10.Connections[_r1]=_r2:Connect(_r3)
end
local function _q12(_r1)
if _q10.Connections[_r1] then _q10.Connections[_r1]:Disconnect() _q10.Connections[_r1]=nil end
end
local function _q13() return _q8.Character end
local function _q14() local _r1=_q13() return _r1 and _r1:FindFirstChildOfClass(_s(72,117,109,97,110,111,105,100)) end
local function _q15() local _r1=_q13() return _r1 and _r1:FindFirstChild(_s(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116)) end
local function _q16(_r1,_r2,_r3)
local _r4=Instance.new(_r1)
for _r5,_r6 in pairs(_r2 or {}) do _r4[_r5]=_r6 end
_r4.Parent=_r3
return _r4
end
local _q17=_q16(_s(83,99,114,101,101,110,71,117,105),{Name=_s(65,114,115,101,110,97,108,69,108,105,116,101),ResetOnSpawn=false,IgnoreGuiInset=true,DisplayOrder=999,ZIndexBehavior=Enum.ZIndexBehavior.Sibling},_q8:WaitForChild(_s(80,108,97,121,101,114,71,117,105)))
local _q18=_q16(_s(84,101,120,116,76,97,98,101,108),{Visible=false,ZIndex=10,AnchorPoint=Vector2.new(1,0),Position=UDim2.fromScale(0.985,0.035),Size=UDim2.fromOffset(320,44),BackgroundColor3=Color3.fromRGB(25,25,34),BackgroundTransparency=0.08,BorderSizePixel=0,TextColor3=Color3.fromRGB(245,245,255),Font=Enum.Font.GothamMedium,TextSize=14,TextWrapped=true,Text=_s(32)},_q17)
_q16(_s(85,73,67,111,114,110,101,114),{CornerRadius=UDim.new(0,8)},_q18)
_q16(_s(85,73,83,116,114,111,107,101),{Color=Color3.fromRGB(0,190,255),Transparency=0.25},_q18)
local function _q19(_r1)
_q18.Text=_r1 _q18.Visible=true _q18.BackgroundTransparency=1 _q18.TextTransparency=1
_q4:Create(_q18,TweenInfo.new(0.18),{BackgroundTransparency=0.08,TextTransparency=0}):Play()
task.delay(3,function()
if _q18.Text==_r1 then
local _r2=_q4:Create(_q18,TweenInfo.new(0.18),{BackgroundTransparency=1,TextTransparency=1})
_r2:Play() _r2.Completed:Wait() _q18.Visible=false
end end)
end
local function _q1a(_r1,_r2)
local _r3=_q16(_s(84,101,120,116,66,117,116,116,111,110),{Size=UDim2.new(1,0,0,38),BackgroundColor3=Color3.fromRGB(32,34,48),BorderSizePixel=0,AutoButtonColor=false,Text=_r2,TextColor3=Color3.fromRGB(240,245,255),Font=Enum.Font.GothamMedium,TextSize=14},_r1)
_q16(_s(85,73,67,111,114,110,101,114),{CornerRadius=UDim.new(0,7)},_r3)
_q16(_s(85,73,83,116,114,111,107,101),{Color=Color3.fromRGB(64,70,92),Transparency=0.45},_r3)
_r3.MouseEnter:Connect(function() _q4:Create(_r3,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(42,48,70)}):Play() end)
_r3.MouseLeave:Connect(function() _q4:Create(_r3,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(32,34,48)}):Play() end)
return _r3
end
local function _q1b(_r1,_r2,_r3,_r4)
local _r5=_r3==true
local _r6=_q1a(_r1,_r2.._s(58,32)..(_r5 and _s(79,78) or _s(79,70,70)))
_r6.MouseButton1Click:Connect(function()
_r5=not _r5
_r6.Text=_r2.._s(58,32)..(_r5 and _s(79,78) or _s(79,70,70))
_r4(_r5)
end)
return _r6
end
local _q1c=0
local function _q1d(_r1,_r2,_r3,_r4,_r5,_r6)
_q1c+=1
local _r7=_s(83,108,105,100,101,114,95)..tostring(_q1c)
local _r8=_q16(_s(70,114,97,109,101),{Size=UDim2.new(1,0,0,58),BackgroundColor3=Color3.fromRGB(27,29,41),BorderSizePixel=0},_r1)
_q16(_s(85,73,67,111,114,110,101,114),{CornerRadius=UDim.new(0,7)},_r8)
local _r9=_q16(_s(84,101,120,116,76,97,98,101,108),{Size=UDim2.new(1,-18,0,26),Position=UDim2.fromOffset(9,4),BackgroundTransparency=1,TextColor3=Color3.fromRGB(235,238,255),Font=Enum.Font.GothamMedium,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,Text=_r2.._s(58,32)..tostring(_r5)},_r8)
local _ra=_q16(_s(70,114,97,109,101),{Position=UDim2.fromOffset(10,36),Size=UDim2.new(1,-20,0,6),BackgroundColor3=Color3.fromRGB(48,52,72),BorderSizePixel=0},_r8)
_q16(_s(85,73,67,111,114,110,101,114),{CornerRadius=UDim.new(1,0)},_ra)
local _rb=_q16(_s(70,114,97,109,101),{Size=UDim2.fromScale((_r5-_r3)/(_r4-_r3),1),BackgroundColor3=Color3.fromRGB(0,190,255),BorderSizePixel=0},_ra)
_q16(_s(85,73,67,111,114,110,101,114),{CornerRadius=UDim.new(1,0)},_rb)
local _rc=false
local function _rd(_re)
local _rf=math.clamp((_re-_ra.AbsolutePosition.X)/_ra.AbsoluteSize.X,0,1)
local _rg=math.floor(_r3+(_r4-_r3)*_rf)
_rb.Size=UDim2.fromScale(_rf,1)
_r9.Text=_r2.._s(58,32)..tostring(_rg)
_r6(_rg)
end
_ra.InputBegan:Connect(function(_rh) if _rh.UserInputType==Enum.UserInputType.MouseButton1 then _rc=true _rd(_rh.Position.X) end end)
_q11(_r7.._s(95,69,110,100),_q3.InputEnded,function(_rh) if _rh.UserInputType==Enum.UserInputType.MouseButton1 then _rc=false end end)
_q11(_r7.._s(95,77,111,118,101),_q3.InputChanged,function(_rh) if _rc and _rh.UserInputType==Enum.UserInputType.MouseMovement then _rd(_rh.Position.X) end end)
return _r8
end
local _q1e
local _q1f
local _q20=loadstring(game:HttpGet(_s(104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,115,46,99,111,109,47,108,117,99,97,115,108,117,99,97,115,49,57,56,47,83,99,114,105,112,116,105,110,103,72,117,98,75,101,121,83,121,115,116,101,109,47,109,97,105,110,47,75,101,121,83,121,115,116,101,109,46,108,117,97)))()
_q20.show({ScriptName=_s(65,114,115,101,110,97,108,32,69,108,105,116,101),KeyFile=_qe,ExpFile=_qf,IsFPS=true,ValidKey=_qd,OnSuccess=function()
_qc=true
_q1e.Visible=true _q1e.BackgroundTransparency=1
_q4:Create(_q1e,TweenInfo.new(0.22),{BackgroundTransparency=0}):Play()
_q1f(_s(77,111,118,101,109,101,110,116))
_q19(_s(65,99,99,101,115,115,32,103,114,97,110,116,101,100,46,32,65,114,115,101,110,97,108,32,69,108,105,116,101,32,108,111,97,100,101,100,46))
end})
_q1e=_q16(_s(70,114,97,109,101),{Visible=false,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(760,500),BackgroundColor3=Color3.fromRGB(16,16,26),BorderSizePixel=0},_q17)
_q16(_s(85,73,67,111,114,110,101,114),{CornerRadius=UDim.new(0,10)},_q1e)
_q16(_s(85,73,83,116,114,111,107,101),{Color=Color3.fromRGB(0,190,255),Transparency=0.35},_q1e)
local _q21=_q16(_s(70,114,97,109,101),{Size=UDim2.fromOffset(178,500),BackgroundColor3=Color3.fromRGB(20,20,32),BorderSizePixel=0},_q1e)
_q16(_s(85,73,67,111,114,110,101,114),{CornerRadius=UDim.new(0,10)},_q21)
_q16(_s(84,101,120,116,76,97,98,101,108),{Position=UDim2.fromOffset(18,16),Size=UDim2.new(1,-36,0,34),BackgroundTransparency=1,Text=_s(65,114,115,101,110,97,108,32,69,108,105,116,101),TextColor3=Color3.fromRGB(255,255,255),Font=Enum.Font.GothamBold,TextSize=20,TextXAlignment=Enum.TextXAlignment.Left},_q21)
local _q22=_q16(_s(70,114,97,109,101),{Position=UDim2.fromOffset(14,68),Size=UDim2.new(1,-28,1,-82),BackgroundTransparency=1},_q21)
_q16(_s(85,73,76,105,115,116,76,97,121,111,117,116),{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder},_q22)
local _q23=_q16(_s(70,114,97,109,101),{Position=UDim2.fromOffset(198,18),Size=UDim2.new(1,-216,1,-36),BackgroundTransparency=1},_q1e)
local _q24={}
local function _q25(_r1)
local _r2=_q16(_s(83,99,114,111,108,108,105,110,103,70,114,97,109,101),{Visible=false,Size=UDim2.fromScale(1,1),CanvasSize=UDim2.fromOffset(0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=4,BackgroundTransparency=1,BorderSizePixel=0},_q23)
_q16(_s(85,73,76,105,115,116,76,97,121,111,117,116),{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder},_r2)
_q16(_s(84,101,120,116,76,97,98,101,108),{Size=UDim2.new(1,0,0,42),BackgroundTransparency=1,Text=_r1,TextColor3=Color3.fromRGB(255,255,255),Font=Enum.Font.GothamBold,TextSize=26,TextXAlignment=Enum.TextXAlignment.Left},_r2)
_q24[_r1]=_r2
return _r2
end
_q1f=function(_r1) for _r2,_r3 in pairs(_q24) do _r3.Visible=_r2==_r1 end end
local function _q26(_r1)
local _r2=_q1a(_q22,_r1)
_r2.MouseButton1Click:Connect(function() _q1f(_r1) end)
end
local _q27=_q25(_s(77,111,118,101,109,101,110,116))
local _q28=_q25(_s(80,108,97,121,101,114))
local _q29=_q25(_s(87,101,97,112,111,110,32,81,65))
local _q2a=_q25(_s(87,111,114,108,100))
local _q2b=_q25(_s(83,101,116,116,105,110,103,115))
local _q2c=_q25(_s(67,114,101,100,105,116,115))
_q26(_s(77,111,118,101,109,101,110,116))
_q26(_s(80,108,97,121,101,114))
_q26(_s(87,101,97,112,111,110,32,81,65))
_q26(_s(87,111,114,108,100))
_q26(_s(83,101,116,116,105,110,103,115))
_q26(_s(67,114,101,100,105,116,115))
local function _q2d()
local _r1=_q6:FindFirstChild(_s(68,101,118,101,108,111,112,101,114,87,101,97,112,111,110,67,111,110,116,114,111,108))
if _r1 and _r1:IsA(_s(82,101,109,111,116,101,69,118,101,110,116)) then
_r1:FireServer({RecoilReduction=_q10.Config.RecoilReduction,SpreadReduction=_q10.Config.SpreadReduction,RapidFire=_q10.Config.RapidFire,InfiniteAmmo=_q10.Config.InfiniteAmmo,AutoReload=_q10.Config.AutoReload})
else _q19(_s(68,101,118,101,108,111,112,101,114,87,101,97,112,111,110,67,111,110,116,114,111,108,32,82,101,109,111,116,101,69,118,101,110,116,32,110,111,116,32,102,111,117,110,100,46)) end
end
local function _q2e()
_q5.FogEnd=_q10.Config.RemoveFog and 100000 or _q10.Original.Lighting.FogEnd
_q5.FogStart=_q10.Config.RemoveFog and 0 or _q10.Original.Lighting.FogStart
_q5.GlobalShadows=not _q10.Config.RemoveShadows
_q5.ClockTime=_q10.Config.Time
_q7.Gravity=_q10.Config.Gravity
if _q10.Config.Fullbright then _q5.Brightness=2 _q5.Ambient=Color3.fromRGB(255,255,255)
else _q5.Brightness=_q10.Original.Lighting.Brightness _q5.Ambient=_q10.Original.Lighting.Ambient end
end
local _q2f local _q30
local function _q31(_r1)
local _r2=_q15()
if not _r2 then return end
if _r1 then
_q2f=Instance.new(_s(66,111,100,121,86,101,108,111,99,105,116,121))
_q2f.MaxForce=Vector3.new(100000,100000,100000) _q2f.Velocity=Vector3.zero _q2f.Parent=_r2
_q30=Instance.new(_s(66,111,100,121,71,121,114,111))
_q30.MaxTorque=Vector3.new(100000,100000,100000) _q30.P=9000 _q30.CFrame=_q9.CFrame _q30.Parent=_r2
_q11(_s(70,108,121,76,111,111,112),_q2.RenderStepped,function()
local _r3=_q7.CurrentCamera if not _r3 then return end
local _r4=Vector3.zero
if _q3:IsKeyDown(Enum.KeyCode.W) then _r4+=_r3.CFrame.LookVector end
if _q3:IsKeyDown(Enum.KeyCode.S) then _r4-=_r3.CFrame.LookVector end
if _q3:IsKeyDown(Enum.KeyCode.A) then _r4-=_r3.CFrame.RightVector end
if _q3:IsKeyDown(Enum.KeyCode.D) then _r4+=_r3.CFrame.RightVector end
if _q3:IsKeyDown(Enum.KeyCode.Space) then _r4+=Vector3.yAxis end
if _q3:IsKeyDown(Enum.KeyCode.LeftControl) then _r4-=Vector3.yAxis end
_q2f.Velocity=_r4.Magnitude>0 and _r4.Unit*_q10.Config.FlySpeed or Vector3.zero
_q30.CFrame=_r3.CFrame
end)
else
_q12(_s(70,108,121,76,111,111,112))
if _q2f then _q2f:Destroy() _q2f=nil end
if _q30 then _q30:Destroy() _q30=nil end
end
end
_q1b(_q27,_s(83,112,101,101,100),false,function(_r1) _q10.Config.SpeedEnabled=_r1 end)
_q1d(_q27,_s(87,97,108,107,32,83,112,101,101,100),16,90,_q10.Config.WalkSpeed,function(_r1) _q10.Config.WalkSpeed=_r1 end)
_q1b(_q27,_s(74,117,109,112,32,80,111,119,101,114),false,function(_r1) _q10.Config.JumpEnabled=_r1 end)
_q1d(_q27,_s(74,117,109,112,32,80,111,119,101,114,32,86,97,108,117,101),50,160,_q10.Config.JumpPower,function(_r1) _q10.Config.JumpPower=_r1 end)
_q1b(_q27,_s(73,110,102,105,110,105,116,101,32,74,117,109,112),false,function(_r1) _q10.Config.InfiniteJump=_r1 end)
_q1b(_q27,_s(70,108,121),false,function(_r1) _q10.Config.Fly=_r1 _q31(_r1) end)
_q1d(_q27,_s(70,108,121,32,83,112,101,101,100),20,160,_q10.Config.FlySpeed,function(_r1) _q10.Config.FlySpeed=_r1 end)
_q1b(_q27,_s(78,111,99,108,105,112),false,function(_r1) _q10.Config.Noclip=_r1 end)
_q1d(_q28,_s(67,97,109,101,114,97,32,70,79,86),50,120,_q10.Config.CameraFOV,function(_r1) _q10.Config.CameraFOV=_r1 local _r2=_q7.CurrentCamera if _r2 then _r2.FieldOfView=_r1 end end)
_q1b(_q28,_s(65,117,116,111,32,82,101,115,112,97,119,110),false,function(_r1) _q10.Config.AutoRespawn=_r1 end)
_q1b(_q28,_s(65,117,116,111,32,72,101,97,108),false,function(_r1) _q10.Config.AutoHeal=_r1 end)
_q1b(_q28,_s(76,111,119,32,71,114,97,112,104,105,99,115),false,function(_r1)
_q10.Config.LowGraphics=_r1
for _,_r2 in ipairs(_q7:GetDescendants()) do
if _r2:IsA(_s(66,97,115,101,80,97,114,116)) then _r2.CastShadow=not _r1 if _r1 then _r2.Material=Enum.Material.SmoothPlastic end
elseif _r2:IsA(_s(80,97,114,116,105,99,108,101,69,109,105,116,116,101,114)) or _r2:IsA(_s(84,114,97,105,108)) or _r2:IsA(_s(66,101,97,109)) then _r2.Enabled=not _r1 end
end end)
_q1d(_q29,_s(82,101,99,111,105,108,32,82,101,100,117,99,116,105,111,110),0,100,0,function(_r1) _q10.Config.RecoilReduction=_r1 end)
_q1d(_q29,_s(83,112,114,101,97,100,32,82,101,100,117,99,116,105,111,110),0,100,0,function(_r1) _q10.Config.SpreadReduction=_r1 end)
_q1b(_q29,_s(82,97,112,105,100,32,70,105,114,101),false,function(_r1) _q10.Config.RapidFire=_r1 end)
_q1b(_q29,_s(73,110,102,105,110,105,116,101,32,65,109,109,111),false,function(_r1) _q10.Config.InfiniteAmmo=_r1 end)
_q1b(_q29,_s(65,117,116,111,32,82,101,108,111,97,100),false,function(_r1) _q10.Config.AutoReload=_r1 end)
_q1a(_q29,_s(65,112,112,108,121,32,87,101,97,112,111,110,32,81,65,32,83,101,116,116,105,110,103,115)).MouseButton1Click:Connect(_q2d)
_q1b(_q2a,_s(70,117,108,108,98,114,105,103,104,116),false,function(_r1) _q10.Config.Fullbright=_r1 _q2e() end)
_q1b(_q2a,_s(82,101,109,111,118,101,32,70,111,103),false,function(_r1) _q10.Config.RemoveFog=_r1 _q2e() end)
_q1b(_q2a,_s(82,101,109,111,118,101,32,83,104,97,100,111,119,115),false,function(_r1) _q10.Config.RemoveShadows=_r1 _q2e() end)
_q1d(_q2a,_s(84,105,109,101),0,24,_q10.Config.Time,function(_r1) _q10.Config.Time=_r1 _q2e() end)
_q1d(_q2a,_s(71,114,97,118,105,116,121),20,300,_q10.Config.Gravity,function(_r1) _q10.Config.Gravity=_r1 _q2e() end)
_q1a(_q2b,_s(82,101,115,101,116,32,87,111,114,108,100,32,83,101,116,116,105,110,103,115)).MouseButton1Click:Connect(function()
_q10.Config.Fullbright=false _q10.Config.RemoveFog=false _q10.Config.RemoveShadows=false
_q10.Config.Time=_q10.Original.Lighting.ClockTime _q10.Config.Gravity=_q10.Original.Gravity
_q2e() _q19(_s(87,111,114,108,100,32,115,101,116,116,105,110,103,115,32,114,101,115,101,116,46))
end)
_q1a(_q2b,_s(85,110,108,111,97,100,32,85,73)).MouseButton1Click:Connect(function()
for _,_r1 in pairs(_q10.Connections) do _r1:Disconnect() end
_q10.Connections={}
if _q2f then _q2f:Destroy() end if _q30 then _q30:Destroy() end
_q7.Gravity=_q10.Original.Gravity
local _r1=_q7.CurrentCamera if _r1 then _r1.FieldOfView=_q10.Original.FieldOfView end
_q17:Destroy()
end)
_q16(_s(84,101,120,116,76,97,98,101,108),{Size=UDim2.new(1,0,0,72),BackgroundColor3=Color3.fromRGB(27,29,41),BorderSizePixel=0,Text=_s(65,114,115,101,110,97,108,32,69,108,105,116,101,32,45,32,86,101,114,115,105,111,110,32,49,46,48,46,48),TextColor3=Color3.fromRGB(235,238,255),Font=Enum.Font.GothamMedium,TextSize=14,TextWrapped=true},_q2c)
_q11(_s(77,111,118,101,109,101,110,116,76,111,111,112),_q2.Heartbeat,function()
local _r1=_q14()
if _r1 then
_r1.UseJumpPower=true
_r1.WalkSpeed=_q10.Config.SpeedEnabled and _q10.Config.WalkSpeed or _q10.Original.WalkSpeed
_r1.JumpPower=_q10.Config.JumpEnabled and _q10.Config.JumpPower or _q10.Original.JumpPower
end
if _q10.Config.Noclip then
local _r2=_q13()
if _r2 then for _,_r3 in ipairs(_r2:GetDescendants()) do if _r3:IsA(_s(66,97,115,101,80,97,114,116)) then _r3.CanCollide=false end end end
end end)
_q11(_s(73,110,102,105,110,105,116,101,74,117,109,112),_q3.JumpRequest,function()
if _q10.Config.InfiniteJump then local _r1=_q14() if _r1 then _r1:ChangeState(Enum.HumanoidStateType.Jumping) end end
end)
task.spawn(function()
while _q17.Parent do
task.wait(2)
if _q10.Config.AutoRespawn then
local _r1=_q14() local _r2=_q6:FindFirstChild(_s(68,101,118,101,108,111,112,101,114,82,101,115,112,97,119,110))
if _r1 and _r1.Health<=0 and _r2 and _r2:IsA(_s(82,101,109,111,116,101,69,118,101,110,116)) then _r2:FireServer() end
end
if _q10.Config.AutoHeal then
local _r1=_q14() local _r2=_q6:FindFirstChild(_s(68,101,118,101,108,111,112,101,114,72,101,97,108))
if _r1 and _r1.Health<_r1.MaxHealth*0.35 and _r2 and _r2:IsA(_s(82,101,109,111,116,101,69,118,101,110,116)) then _r2:FireServer() end
end end end)
_q11(_s(84,111,103,103,108,101,85,73),_q3.InputBegan,function(_r1,_r2)
if _r2 then return end
if _r1.KeyCode==Enum.KeyCode.K and _qc then _q1e.Visible=not _q1e.Visible end
if _r1.KeyCode==Enum.KeyCode.T then
_qb=not _qb
if not _qb then _q3.MouseBehavior=Enum.MouseBehavior.LockCenter end
end end)
_q11(_s(77,111,117,115,101,85,110,108,111,99,107),_q2.Heartbeat,function()
if _q1e.Visible or _qb then _q3.MouseBehavior=Enum.MouseBehavior.Default end
end)
_q19(_s(65,114,115,101,110,97,108,32,69,108,105,116,101,32,108,111,97,100,101,100,46))
