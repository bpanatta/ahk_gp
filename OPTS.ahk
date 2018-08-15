#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; Variables
char := "shanks"
;char := "sabo"

; Functions
ClickYes(position)
{
	;IfNotExist, imgs/btn-yes.png
		;MsgBox, File not found.
	imgBasePath := "imgs/btn-yes"
	
	Loop, 3
	{
		imgSrc := % imgBasePath . A_Index . ".png"
		if (position = "center")
		{
			ImageSearch pX, pY, 860, 500, 1045, 710, %imgSrc%
		}
		else if (position = "middle")
		{
			ImageSearch pX, pY, 990, 510, 1170, 590, %imgSrc%
		}
		else
		{
			ImageSearch pX, pY, 706, 60, 1215, 966, %imgSrc%
		}
		
		if (pX and pY)
		{
			MouseClick, L, %pX%, %pY%
			return true
		}
	}
	return false
}
ClickNo(position)
{
	if (position = "middle")
	{
		ImageSearch pX, pY, 750, 510, 950, 590, imgs/btn-no.png
	}
	else
	{
		ImageSearch pX, pY, 706, 60, 1215, 966, imgs/btn-no.png
	}
	
	if (pX and pY)
	{
		MouseClick, L, %pX%, %pY%
		return true
	}
	return false
}

ClickNext(position)
{
	if (position = "middle")
	{
		ImageSearch pX, pY, 990, 510, 1170, 590, imgs/btn-next.png
	}
	else if (position = "bottom")
	{
		ImageSearch pX, pY, 870, 860, 1055, 960, imgs/btn-next.png
	}
	else
	{
		ImageSearch pX, pY, 706, 60, 1215, 966, imgs/btn-next.png
	}
	
	if (pX and pY)
	{
		MouseClick, L, %pX%, %pY%
		return true
	}
	return false
}
ClickBack(position)
{
	imgBasePath := "imgs/btn-back"
	
	Loop, 3
	{
		imgSrc := % imgBasePath . A_Index . ".png"
		if (position = "bottom")
		{
			ImageSearch pX, pY, 706, 880, 860, 952, %imgSrc%
		}
		else
		{
			ImageSearch pX, pY, 706, 60, 1215, 966, %imgSrc%
		}
		
		if (pX and pY)
		{
			MouseClick, L, %pX%, %pY%
			return true
		}
	}
	return false
}
ClickSkip()
{
	ImageSearch pX, pY, 1074, 60, 1199, 108, imgs/btn-skip.png
	
	if (pX and pY)
	{
		MouseClick, L, %pX%, %pY%
		return true
	}
	return false
}

ClickEpilogue()
{
	ImageSearch pX, pY, 897, 237, 1012, 317, imgs/epilogue.png
	
	if (pX and pY)
	{
		MouseClick, L, %pX%, %pY%
		return true
	}
	return false
}
ClickPrologue()
{
	ImageSearch pX, pY, 897, 237, 1012, 317, imgs/prologue2.png
	
	if (pX and pY)
	{
		MouseClick, L, %pX%, %pY%
		return true
	}
	return false
}

MovePad(padMove)
{
	if (padMove > 0)
	{
		Loop %padMove%
		{
			SendEvent {Click 954, 861, down}
			mousePosY := 861
			Loop 9
			{
				mousePosY := mousePosY - 50
				MouseMove, 954, mousePosY, 100
				Sleep 100
			}
			Sleep 100
			SendEvent {click 954, 415, up}
			Sleep 4000
		}
	}
	else if (padMove < 0)
	{
		padMove := - padMove
		Loop %padMove%
		{
			SendEvent {Click 954, 415, down}
			mousePosY := 415
			Loop 9
			{
				mousePosY := mousePosY + 50
				MouseMove, 954, mousePosY, 100
				Sleep 100
			}
			Sleep 100
			SendEvent {click 954, 861, up}
			Sleep 4000
		}
	}
}

StartGame(gameNum, matchType)
{
	MouseMove, 974, 515
	if (gameNum > 4)
	{
		padDown := Floor(gameNum / 4)
		MovePad(padDown)
		gameNum := gameNum - (padDown * 3)
	}
	gameNum := gameNum + 5
	Send, %gameNum%
	Sleep, 2000
	
	if (matchType = "free")
	{
		Send, S
	} else {
		Send, E
	}
	
	Sleep, 25000
	Send, D
}

EndGame()
{
	Send, D
	Sleep, 2000
	
	; Check that the game has finished
	While ClickNext("bottom")
		Sleep, 1000
	
	Sleep, 2000
	
	Loop 7
	{
		Sleep, 800
		Send, T
		Send, G
	}
	
	; Click the yes button in the center for first time completition
	;While ClickYes("center")
	;	Sleep, 1000
	
	Sleep, 2000
	Send, G
	Sleep, 5000
	Send, G
	
	; Return to main screen
	Sleep, 3000
	;Send, Q
	;return true
	Loop, 5
	{
		if (ClickBack("bottom"))
			return true
		Sleep, 1000
	}
	
	return false
}

FightStage(stageNum)
{
	if (char = "fuijtora")
	{
		Sleep, 10000
		Send, R
		Sleep, 15000
		Send, W
		Sleep, 8000
		Send, R
		Sleep, 12000
		Send, E
		Sleep, 9000
		Send, W
		Sleep, 9000
		Send, R
	}
	else if (char = "sabo")
	{
		Sleep, 10000
		Loop, 5
		{
			Sleep, 200
			Send, W
		}
		Sleep, 14000
		Loop, 5
		{
			Sleep, 200
			Send, E
		}
		Sleep 19000
		Loop, 5
		{
			Sleep, 200
			Send, W
		}
		Sleep 14000
		Loop, 5
		{
			Sleep, 200
			Send, E
		}
	}
	else
	{
		Sleep, 45000
		Loop, 5
		{
			Sleep, 200
			Send, W
		}
		Sleep 15000
	}
}

FightBoss(specialRuns)
{
	Loop %specialRuns%
	{
		Loop, 6
		{
			Sleep, 200
			Send, W
		}
		Sleep, 5000
		Loop, 6
		{
			Sleep, 200
			Send, R
		}
		Sleep, 5000
		Send %A_Tab%
		Loop, 6
		{
			Sleep, 200
			Send, E
		}
		Sleep, 5000
	}
}
FightFameBoss()
{
	Loop 12
	{
		Loop, 6
		{
			Sleep, 200
			Send, W
		}
		Sleep, 2000
		Loop, 6
		{
			Sleep, 200
			Send, R
		}
		Sleep, 2100
		Send %A_Tab%
		Loop, 6
		{
			Sleep, 200
			Send, E
		}
		Sleep, 2000
	}
}

PlayFullGame(gameNum, stageQty, bossDificulty)
{
	StartGame(gameNum, "strength")
	
	stageNum := 1
	Sleep, 20000
	FightStage(1)
	
	if (stageQty > 1)
	{
		stageNum := stageNum + 1
		Sleep, 10000
		FightStage(stageNum)
	}
	
	Sleep, 10000
	FightBoss(bossDificulty)
	
	Sleep, 30000
	Loop
		Sleep, 1000
	Until EndGame()
}

PlayFullGame2(gameNum, stageQty, bossDificulty)
{
	StartGame(gameNum, "strength")
	
	stageNum := 1
	Sleep, 20000
	FightStage(1)
	
	if (stageQty > 1)
	{
		stageNum := stageNum + 1
		Sleep, 10000
		FightStage(stageNum)
	}
	
	Sleep, 10000
	play := true
	endGame := false
	While play
	{
		FightBoss(1)
		
		if (ClickNext("bottom"))
		{
			play := false
			endGame := true
		}
		if (ClickBack("bottom"))
			play := false
		
		Send, G
		Send, D
	}
	
	While (endGame)
	{
		Loop 4
		{
			Sleep, 800
			Send, T
			Send, G
			Send, D
		}
		
		Loop, 2
		{
			if (ClickBack("bottom"))
				endGame := false
			Sleep, 800
		}
	}
}

PlayPrologue()
{
	ClickPrologue()
	Sleep, 4000

	Loop, 20 {
		if (ClickSkip())
			break
		Sleep, 1000
	}
}
PlayEpilogue()
{
	ClickEpilogue()
	Sleep, 4000

	Loop, 20 {
		if (ClickSkip())
			break
		Sleep, 1000
	}

	Sleep, 6000
	Loop, 10 {
		ClickYes("center")
		Sleep, 1000
	}
}


; Scroll down
#IfWinActive BlueStacks
!Z::
MovePad(1)
return

; Scroll up
#IfWinActive BlueStacks
!C::
MovePad(-1)
return

; Finish a game
#IfWinActive BlueStacks
!F::
EndGame()
return


; Finish a game
#IfWinActive BlueStacks
+F::
InputBox, nGame, Configuration, What is the game position in the list?

if (nGame = "")
    return  ; User pressed the "Cancel" button.

Sleep, 300

Loop
{
	StartGame(nGame, "strength")
	
	Sleep, 20000
	FightFameBoss()
	
	Sleep, 20000
	Loop
		Sleep, 1000
	Until EndGame()
	Sleep, 8000
}

MsgBox, Finished Fame Farm

return


; Play from home screen
+P::
InputBox, nPlays, Configuration, How many plays?
InputBox, nGame, Configuration, What is the game position in the list?
InputBox, nStages, Configuration, How many stages does the game have before the boss?
InputBox, bossDificulty, Configuration, How difficult is the boss?

IfMsgBox, Cancel
    Return  ; User pressed the "Cancel" button.

Sleep, 300
#IfWinActive BlueStacks
Loop %nPlays%
{
	PlayFullGame2(nGame, nStages, bossDificulty)
	Sleep, 8000
}
MsgBox, Finished playing
return


; Play Daily quests
+D::
;nPlay := 0
nGame := 1

InputBox, nGames, Configuration, What is the number of different games to be played?
InputBox, nTimesEach, Configuration, How many times to play each game?

IfMsgBox, Cancel
    Return  ; User pressed the "Cancel" button.

Sleep, 200
#IfWinActive BlueStacks
Loop
{
	if (nGames = 1)
	{
		PlayFullGame(1, 1, 2)
	} else {
		;nPlay := nPlay + 1
		PlayFullGame(nGame, 1, 2)
		
		if (Mod(A_Index, nTimesEach) = 0)
		{
			nGame := nGame + 1
			if (nGame > nGames)
				nGame := 1
		}
	}
	Sleep, 8000
}

MsgBox, Finished playing
return


; Play Regular quests
#IfWinActive BlueStacks
+R::
nPlay := 1

InputBox, nGames, Configuration, How many different games are to be played en each difficulty?
InputBox, nDificulties, Configuration, How many difficulty levels?
InputBox, nStart, Configuration, Start from quest number?
InputBox, nDifficulty, Configuration, Starting difficulty?

IfMsgBox, Cancel
    return  ; User pressed the "Cancel" button.

if (nStart = 0)
{
	PlayPrologue()
	nStart := 1
}

if (nStart > 1)
	nPlay := nStart

Loop %nDificulties%
{
	Loop %nGames%
	{
		if (Mod(nPlay, 3) = 0)
		{
			; Play Boss quest
			PlayFullGame(0, (%nDifficulty% + 1), (%nDifficulty% + 1))
		} else {
			; Play transition quest
			PlayFullGame(0, %nDifficulty%, %nDifficulty%)
		}
		nPlay := nPlay + 1
		Sleep, 8000
	}
	
	if (nDificulties = 2)
	{
		PlayEpilogue()
		Sleep, 500
		Send, M
	}
	else if (nDificulties = 3)
	{
		PlayEpilogue()
		Sleep, 500
		if (A_Index = 1)
			Send, N
		else
			Send, M
	}
	Sleep, 4000
	nDifficulty := nDifficulty + 1
}

MsgBox, Finished playing
return


; Test for imagesearch
#IfWinActive BlueStacks
+Z::
ClickBack("bottom")
return

; Click epilogue
#IfWinActive BlueStacks
!E::
PlayPrologue()
return

#IfWinActive BlueStacks
+X::
MouseGetPos, xpos, ypos 
MsgBox, The cursor is at X%xpos% Y%ypos%. 
return