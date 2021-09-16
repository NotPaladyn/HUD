--[[
Skrypt został wykonany przez:
    •NotPaladyn (not.paladyn@gmail.com) (NotPaladyn#0477)

Zasób napisany dla użytkowników forum GTAONLINE.PL
]]--

local sw,sh = guiGetScreenSize()
local baseX = 1920
local zoom = 1
local minzoom = 2
if sw < baseX then
    zoom = math.min(minzoom, baseX/sw)
end

hud = {
    isOpen = true,

    money_icon = dxCreateTexture("images/money_icon.png", "argb", false, "clamp"),
    rp_icon = dxCreateTexture("images/rp_icon.png", "argb", false, "clamp"),

    font = dxCreateFont("fonts/Exo2-Light.ttf", 13),

    health = {x=sw-215/zoom, y=30/zoom, w=200/zoom, h=4/zoom},
    armor = {x=sw-215/zoom, y=60/zoom, w=200/zoom, h=4/zoom},
    i_money = {x=sw-40/zoom, y=80/zoom, w=20/zoom, h=20/zoom},
    t_money = {x=sw-215/zoom, y=80/zoom, w=sw-45/zoom, h=100/zoom},
    i_rp = {x=sw-40/zoom, y=105/zoom, w=20/zoom, h=20/zoom},
    t_rp = {x=sw-215/zoom, y=105/zoom, w=sw-45/zoom, h=125/zoom},
}

hud.ui = function()
    if not hud.isOpen then return end
    if not getElementData(localPlayer, "player:logged") then return end
    local pHealth = getElementHealth(localPlayer)
    local pArmor = getPedArmor(localPlayer)
    local pMoney = getPlayerMoney(localPlayer)
    local pRP = getElementData(localPlayer, "player:srp") or 0
    dxDrawRectangle(hud.health.x, hud.health.y, hud.health.w, hud.health.h, tocolor(30, 30, 30))
    dxDrawRectangle(hud.health.x+1/zoom, hud.health.y+1/zoom, (pHealth/100)*hud.health.w-2/zoom, hud.health.h-2/zoom, tocolor(250, 30, 30))

    dxDrawRectangle(hud.armor.x, hud.armor.y, hud.armor.w, hud.armor.h, tocolor(30, 30, 30))
    dxDrawRectangle(hud.armor.x+1/zoom, hud.armor.y+1/zoom, (pArmor/100)*hud.armor.w-2/zoom, hud.armor.h-2/zoom, tocolor(30, 120, 250))

    dxDrawImage(hud.i_money.x, hud.i_money.y, hud.i_money.w, hud.i_money.h, hud.money_icon)
    dxDrawText(formatMoney(pMoney), hud.t_money.x+1/zoom, hud.t_money.y+1/zoom, hud.t_money.w+1/zoom, hud.t_money.h+1/zoom, tocolor(0, 0, 0), 1/zoom, hud.font, "right", "center")
    dxDrawText(formatMoney(pMoney), hud.t_money.x, hud.t_money.y, hud.t_money.w, hud.t_money.h, tocolor(255, 255, 255), 1/zoom, hud.font, "right", "center")

    dxDrawImage(hud.i_rp.x, hud.i_rp.y, hud.i_rp.w, hud.i_rp.h, hud.rp_icon)
    dxDrawText(pRP, hud.t_rp.x+1/zoom, hud.t_rp.y+1/zoom, hud.t_rp.w+1/zoom, hud.t_rp.h+1/zoom, tocolor(0, 0, 0), 1/zoom, hud.font, "right", "center")
    dxDrawText(pRP, hud.t_rp.x, hud.t_rp.y, hud.t_rp.w, hud.t_rp.h, tocolor(255, 255, 255), 1/zoom, hud.font, "right", "center")
end
addEventHandler("onClientRender", root, hud.ui)

function toggleHUD(key, state)
    if key == "F11" and state then
        if hud.isOpen then
            hud.isOpen = false
        else
            hud.isOpen = true
        end
    end
end
addEventHandler("onClientKey", root, toggleHUD)