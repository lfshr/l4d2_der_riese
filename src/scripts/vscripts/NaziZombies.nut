// Copyright 2019 Liam Fisher

// Permission is hereby granted, free of charge, to any person obtaining a copy 
// of this software and associated documentation files (the "Software"), 
// to deal in the Software without restriction, including without limitation 
// the rights to use, copy, modify, merge, publish, distribute, sublicense, 
// and/or sell copies of the Software, and to permit persons to whom the 
// Software is furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included 
// in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
//  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH 
//  THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
printl("Nazi Zombies Mutation loading...")

::NaziZombies <- {
    DEFAULT_REVIVE_TIME = 5.0
    QUICK_RELOAD_SPEED = 2.0
    QUICK_REVIVE_SPEED = 3.0
    HEALTH_WITHOUT_JUGGERNAUT = 100
    HEALTH_WITH_JUGGERNAUT = 250
    SECONDS_AFTER_HIT_BEFORE_REGEN = 2.0
    HEALTH_REGEN_RATE = 10.0

    Players = array(8)
};

getconsttable()["JUGGERNAUT"] <- 1
getconsttable()["QUICKREVIVE"] <- 2
getconsttable()["QUICKRELOAD"] <- 4

IncludeScript("VSLib.nut");
IncludeScript("NaziZombies/Player.nut")

function Notifications::OnWeaponReload::QuickReload(entity, bManual, params)
{
    if (entity.GetPlayerType() == Z_SURVIVOR) {
        ::NaziZombies.Player(entity).QuickReload(::NaziZombies.QUICK_RELOAD_SPEED)
    }
}

function Notifications::OnReviveBegin::QuickRevive(revivee, revivor, params) 
{
    if(revivor.GetPlayerType() == Z_SURVIVOR) {
        ::NaziZombies.Player(revivor).QuickRevive(revivee, ::NaziZombies.QUICK_REVIVE_SPEED)
    }
}

function Notifications::OnReviveEnd::CancelQuickRevive(revivee, revivor, params)
{
    if(revivor.GetPlayerType() == Z_SURVIVOR) {
        ::NaziZombies.Player(revivor).CancelQuickRevive()
    }
}


function Notifications::OnFirstSpawn::AddPlayer(player, params)
{
        local nzPlayer = ::NaziZombies.Player(player)
        nzPlayer.EnableEffect(JUGGERNAUT)
        ::NaziZombies.Players[nzPlayer.GetIndex()] = nzPlayer
}

function EasyLogic::OnGameplayStart::StartNaziZombies(mode, map)
{
    printl("Starting Gameplay...")

    printl("Nazi Zombies Mutation loading... Done!")
}
