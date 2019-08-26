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

class ::NaziZombies.Player extends ::VSLib.Player {

    constructor(index)
	{
		base.constructor(index);
	}

	hasQuickReload = true
	hasQuickRevive = true
}

function NaziZombies::Player::QuickReload(speed) 
{
	if(hasQuickReload) {
		local weapon = GetActiveWeapon()
		local curTime = Time()
		local nextPrimaryAttack = weapon.GetNetProp("m_flNextPrimaryAttack")
		local nextSecondaryAttack = weapon.GetNetProp("m_flNextSecondaryAttack")

		nextPrimaryAttack = curTime + (nextPrimaryAttack - curTime) / speed
		nextSecondaryAttack = curTime + (nextSecondaryAttack - curTime) / speed
		
		weapon.SetNetProp("m_flPlaybackRate", speed)
		weapon.SetNetProp("m_flNextPrimaryAttack", nextPrimaryAttack)
		weapon.SetNetProp("m_flNextSecondaryAttack", nextSecondaryAttack)
		SetNetProp("m_flNextAttack", nextPrimaryAttack)
	}
}

function NaziZombies::Player::QuickRevive(revivee, speed) {
	local quickReviveTimerName = GetBaseCharacterName() + "_quickrevive"

	if(hasQuickRevive) {
		local timerParams = {
			revivee = revivee
			revivor = this
		}

		Timers.AddTimerByName(quickReviveTimerName,
			::NaziZombies.DEFAULT_REVIVE_TIME / speed,
			false,
			CompleteQuickRevive,
			timerParams)
	}
}

function NaziZombies::Player::CompleteQuickRevive(params){
	::NaziZombies.Player(params.revivee).Revive()
}

function NaziZombies::Player::CancelQuickRevive() {
	local quickReviveTimerName = GetBaseCharacterName() + "_quickrevive"
	Timers.RemoveTimerByName(quickReviveTimerName)
}