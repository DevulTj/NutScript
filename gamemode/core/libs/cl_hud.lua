nut.hud = {}

local owner, w, h, ceil, ft, clmp
ceil = math.ceil
clmp = math.Clamp
local aprg, aprg2 = 0, 0
function nut.hud.drawDeath()
	owner = LocalPlayer()
	ft = FrameTime()
	w, h = ScrW(), ScrH()

	if (owner:Alive() and owner:getChar()) then
		if (aprg != 0) then
			aprg2 = clmp(aprg2 - ft*1.3, 0, 1)
			if (aprg2 == 0) then
				aprg = clmp(aprg - ft*.7, 0, 1)
			end
		end
	else
		if (aprg2 != 1) then
			aprg = clmp(aprg + ft*.5, 0, 1)
			if (aprg == 1) then
				aprg2 = clmp(aprg2 + ft*.4, 0, 1)
			end
		end
	end

	if (nut.gui.char:IsVisible() or !owner:getChar()) then
		return
	end

	surface.SetDrawColor(0, 0, 0, ceil((aprg^.5) * 255))
	surface.DrawRect(0, 0, w, h)
	nut.util.drawText(L"youreDead", w/2, h/2, ColorAlpha(color_white, aprg2 * 255), 1, 1, "nutDynFontMedium", aprg2 * 255)
end

hook.Add("GetCrosshairAlpha", "nutCrosshair", function(alpha)
	return alpha * (1 - aprg)
end)

function nut.hud.drawAll()
	nut.hud.drawDeath()
end