#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <ButtonConstants.au3>
#include <IE.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <Inet.au3>
#include <array.au3>
#include <String.au3>


#Region ### START Koda GUI section ### Form=
$Monitor = GUICreate("Eventim Monitor", 442, 388, 364, 370)
GUISetBkColor(0xFFFFFF)
$addEvent = GUICtrlCreateButton("Event hinzufügen", 256, 208, 171, 25)
$deleteEvent = GUICtrlCreateButton("Event entfernen", 256, 240, 171, 25)
$settings = GUICtrlCreateButton("Einstellungen", 256, 344, 171, 25)
$buyTicket = GUICtrlCreateButton("Tickets kaufen", 256, 304, 171, 25)
$background = GUICtrlCreateButton("Informationen zum Ticket", 256, 272, 171, 25)
GUICtrlCreateGroup("Eventname und Ticketinformationen", 16, 8, 217, 241)
$eventNameInput = GUICtrlCreateInput("Eventname", 24, 80, 185, 21)
$idInput = GUICtrlCreateInput("Ticket ID: 19581007", 24, 112, 137, 21)
$ticketTypeInput = GUICtrlCreateInput("Ticket Typ: Sitzplatz", 24, 144, 137, 21)
$priceInput = GUICtrlCreateInput("Preis: € 231,25", 24, 176, 137, 21)
$stackInput = GUICtrlCreateInput("4 Tickets verfügbar!", 24, 208, 137, 21)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFF0000)
$ticketCombo = GUICtrlCreateCombo("Andere Tickets", 24, 32, 185, 25)
GUICtrlSetData(-1, "Einer|nach|dem|anderen")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$eventList = GUICtrlCreateList("", 256, 16, 169, 188)
GUICtrlSetData(-1, "Testevent|Tickets fÃ¼r U2 in HAMBURG am 04.10.18 - Barclaycard Arena Hamburg")
$info = GUICtrlCreateLabel("Updating events...", 8, 368, 91, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


$htmlFileDir = @ScriptDir & "\html\html.txt"

$test = "test"



While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $addEvent
			$event = InputBox("Event hinzufügen", "Danach füge ich sie zu meiner Beobachtungsliste hinzu!", "")
			addEvent()





	EndSwitch
WEnd

Func Settings()
	$settings = GUICreate("Settings.ini", 400, 400, 200, 200)
	GUISetState(@SW_SHOW, $settings)
	$settingsMsg = GUIGetMsg()
	Switch $settingsMsg

		Case $GUI_EVENT_CLOSE


			EndSwitch
EndFunc

Func addEvent()

Local $hFileOpen = FileOpen($htmlFileDir, $FO_OVERWRITE)
    If $hFileOpen = -1 Then
        MsgBox($MB_SYSTEMMODAL, "", "Probleme beim öffnen der Datei.")
        Return False
    EndIf

	$html = _INetGetSource($event)
	FileWrite($hFileOpen, $html)

	FileRead



	;_FileRename_($htmlFileDir, $




EndFunc

Func _FileRename_($s_Source, $s_Destination, $i_Flag = 0)
    Return FileMove($s_Source, $s_Destination, $i_Flag)
EndFunc

