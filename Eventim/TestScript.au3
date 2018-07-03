#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here


#include <MsgBoxConstants.au3>
#include <ButtonConstants.au3>
#include <IE.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <Inet.au3>
#include <Array.au3>
#include <String.au3>
#include <File.au3>

$eventLink = "http://www.eventim.de/u2-hamburg-tickets.html?affiliate=EVE&doc=artistPages%2Ftickets&fun=artist&action=tickets&key=1310658%2410476515&jumpIn=yTix&kuid=694&from=erdetaila"

$event = ""
$html = ""
$a = 0
$i = 0
$option = 0
$quality = 0

Global $optionTickets[15] = [0]
Global $ticketId[10] = [""]
Global $ticketTitle[10] = [""]
Global $ticketPrice[10] = [""]
Global $ticketStatus[10] = [""]
Global $normalTicketInfo[12] = [""]
Global $specialTicketInfo[12] = [""]
Global $normalTicketFullInfo[] = [""]
Global $storeTicketId[] =[""]

AddEvent()


Func AddEvent()

	$eventLink = InputBox("Test", "Add Event down", "http://www.eventim.de/u2-tickets.html?affiliate=EVE&doc=artistPages/tickets&fun=artist&action=tickets&kuid=694")

	$webPage = _INetGetSource($eventLink)

	$eventName = _StringBetween($webPage, "<title>", "</title>")				;Get Name from Event $eventName[0]

	DirCreate(@ScriptDir & "\html\" & $eventName[0])
	DirCreate(@ScriptDir & "\html\" & $eventName[0] & "\splitTickets")

	$splitNormalFileDir = @ScriptDir & "\html\" & $eventName[0] & "\splitTickets\" ;Create normal Text File
	$normalFileDir = @ScriptDir & "\html\" & $eventName[0] & "\normalTickets.txt" ;Create normal Text File
	$specialFileDir = @ScriptDir & "\html\" & $eventName[0] & "\specialTickets.txt";Create special Text File

	Local $hFileOpenNormal = FileOpen($normalFileDir, $FO_OVERWRITE)   			;Open and create normal File for Writing
    If $hFileOpenNormal = -1 Then
        MsgBox($MB_SYSTEMMODAL, "", "Probleme beim öffnen der Hauptfile. Besonderes Ticket oder falscher Link?")
        Return False
    EndIf

	Local $hFileOpenSpecial = FileOpen($specialFileDir, $FO_OVERWRITE) 			;Open and create special File for Writing
    If $hFileOpenSpecial = -1 Then
        MsgBox($MB_SYSTEMMODAL, "", "Probleme beim öffnen der Specialfile.")
        Return False
    EndIf


	;-------Seperating normal Tickets from Special Tickets----------------------------------------------------

	$htmlPage = $webPage														;Splitting the HTML in 2 Parts
																				;Special and Normal Tickets
	$normalTicketInfo = _StringBetween ($htmlPage, "tableAssortmentList_yTix", "</tbody")
	$specialTicketInfo = _StringBetween ($htmlPage, "tableAssortmentList_ySpecial", "</tbody")
																				;tableAssortmentList_ySpecial
	$normalTicketArrayLength = Ubound($normalTicketInfo) -1
	$specialTicketArrayLength = Ubound($specialTicketInfo) -1

	For $i = 0 To $normalTicketArrayLength

		FileWrite($hFileOpenNormal, $normalTicketInfo[$i])

	Next



	;------Seperating Special Tickets------------------------------------------------------------------

	For $i = 0 To $specialTicketArrayLength

		FileWrite($hFileOpenSpecial, $specialTicketInfo[$i])

	Next


	;----- Seperating each normal Ticket from mainfile ------------------------------------------------

													;Open File for Writing
		;EventID - pk_id" value=" BETWEEN " class
		;TicketName - priceCategory"> BETWEEN - </td>
		;TicketPreis - <strong>123,65</strong>
		;Verfügbare Tickets - <option value=" BETWEEN "></option>
		;Verfügbarkeit - <dt class="unavailableYellow">

	Local $splitTickets[30] = [""]


	Local $hFileOpenNormal = FileOpen($normalFileDir, 1)   			;Open and create normal File for Writing
    If $hFileOpenNormal = -1 Then
        MsgBox($MB_SYSTEMMODAL, "", "Probleme beim öffnen der Datei.")
        Return False
    EndIf

	For $i = 1 To _FileCountLines($normalFileDir)
		Local $readLine[30] = [""]
		$readLine[$i] = FileReadLine($normalFileDir, $i)
		If StringLen($readLine[$i]) >= 650 Then
			$splitTickets[$i] = FileOpen($splitNormalFileDir & "Ticket" & $i &".txt", 1)
			If $splitTickets[$i] = -1 Then
				MsgBox($MB_SYSTEMMODAL, "", "Probleme beim öffnen der Datei bei: " & $splitNormalFileDir)
				Return False
			EndIf
			FileWrite($splitTickets[$i], $readLine[$i])
		EndIf
	Next


#cs
	$storeTicketId = _StringBetween($normalFileDir, "pk_id"" value=""", """ class")
	ConsoleWrite( @CRLF & _NowTime(5) & ": Debug storeTicketID: " & $storeTicketId & " < Debug End")

	Sleep(1000)

	;MsgBox(0, "Test", @CRLF & _NowTime(5) & ": Debug storeTicketID: " & $storeTicketId[0] & " < Debug End")
	MsgBox(0, "Test", @CRLF & _NowTime(5) & ": Debug storeTicketID: " & $storeTicketId[1] & " < Debug End")
	MsgBox(0, "Test", @CRLF & _NowTime(5) & ": Debug storeTicketID: " & $storeTicketId[2] & " < Debug End")
	MsgBox(0, "Test", @CRLF & _NowTime(5) & ": Debug storeTicketID: " & $storeTicketId[3] & " < Debug End")
	MsgBox(0, "Test", @CRLF & _NowTime(5) & ": Debug storeTicketID: " & $storeTicketId[4] & " < Debug End")
	MsgBox(0, "Test", @CRLF & _NowTime(5) & ": Debug storeTicketID: " & $storeTicketId[5] & " < Debug End")
	MsgBox(0, "Test", @CRLF & _NowTime(5) & ": Debug storeTicketID: " & $storeTicketId[6] & " < Debug End")
	MsgBox(0, "Test", @CRLF & _NowTime(5) & ": Debug storeTicketID: " & $storeTicketId[7] & " < Debug End")
	MsgBox(0, "Test", @CRLF & _NowTime(5) & ": Debug storeTicketID: " & $storeTicketId[8] & " < Debug End")
	MsgBox(0, "Test", @CRLF & _NowTime(5) & ": Debug storeTicketID: " & $storeTicketId[9] & " < Debug End")



	For $i = 1 To 14
		ConsoleWrite( @CRLF & _NowTime(5) & ": Debug storeTicketID: " & $storeTicketId & " < Debug End")
	Next


#ce

	;----------- Mit for schleife nach ticketID suchen und in array speichern das gleiche mit preis usw
	;------------ wenn disabled ticket auf nich verfügbar setzen


;Also man lässt sich die normalen Tickets immer zuerst anzeigen da
;es ja auch nur gleich viele parameter im normalen ticket gibt 2= tickets  = 2 Ticket Ids
;spezialtickets

;Manuell die Zahlen in Array eintragen keine For Schleife
;für die normalen tickets so weißt du wie viele tickets wo verfügbar sind

;=false gleich das ticket wird rot markiert für nicht verfügbar



	;--------------------------------------------------------------------------------------------------------
#cs
	$Info = StringInStr($webPage, "priceCategoryInfos.push", $STR_NOCASESENSEBASIC)
	$html = StringTrimLeft($webPage, $Info - 1 )
	$Info = StringInStr($html, "</html>", $STR_NOCASESENSEBASIC)					;Separating normal Tickets from special
	$Info2 = StringInStr($html, "</script>", $STR_NOCASESENSEBASIC)

	$html = StringTrimRight($html, $Info - $Info2 )

	FileWrite($hFileOpenNormal, $eventLink & @CRLF & $eventName[0] & @CRLF & $html)	;Cleaning HTML Code

	Local $hFileOpenNormal = FileOpen($normalFileDir)   							;Open and create normal File for Writing
    If $hFileOpenNormal = -1 Then
        MsgBox($MB_SYSTEMMODAL, "", "Probleme beim öffnen der Datei.")
        Return False
    EndIf

	Local $numberOne = 4
	Local $numberTwo = 6
	Local $numberThree = 8
	Local $numberFour = 9

	For $i = 0 To 4 																;Getting Ticket ID's
		$ticketId[$i] = FileReadLine($hFileOpenNormal, $numberOne)
		$numberOne = $numberOne + 10
																					;Getting Ticket Title
		$ticketTitle[$i] = FileReadLine($hFileOpenNormal, $numberTwo)
		$numberTwo = $numberTwo + 10
																					;Getting Ticket Price
		$ticketPrice[$i] = FileReadLine($hFileOpenNormal, $numberThree)
		$numberThree = $numberThree + 10
																					;Getting Ticket Status
		$ticketStatus[$i] = FileReadLine($hFileOpenNormal, $numberFour)
		$numberFour = $numberFour + 10

		;ConsoleWrite(@CRLF & $ticketId[$i])
		;ConsoleWrite(@CRLF & $ticketTitle[$i])
		;ConsoleWrite(@CRLF & $ticketPrice[$i])
		;ConsoleWrite(@CRLF & $ticketStatus[$i])
	Next



	;--------------------------------------------------------------------------------------------------------



	$testSite = $webPage

	For $i = 0 To 10
		Local $tester = "<option value=""" &  $i & """" 							;Getting Html ready to be readen

		$ticketsAvailable = StringInStr($testSite, $tester)
		$testSite = StringTrimLeft($testSite, $ticketsAvailable +1)
		$ticketsAvailable = StringInStr($testSite, "<option value=""" &  $i +1 & """" )

		;MsgBox(0, "Debug", $ticketsAvailable & " - " & $testSite)

		If $ticketsAvailable >= 100 Or $ticketsAvailable = 0 Then
			MsgBox(0, "Debug", "Hier neue For Schleife - " & $ticketsAvailable & " - " & $i & " Shop: " & $option)
			$optionTickets[$option] = $i
			$option = $option + 1
			$i = 0
			If $option > 10 Then
				$i = 10
			EndIf
		EndIf
	Next

	For $x = 1 To 10

		If $optionTickets[$x] = 1 Or $optionTickets = 0 Then
			$optionTickets[$x] = "Nicht Verfügbar"
		EndIf

	Next


	_ArrayDisplay($optionTickets, "Egal")

	;--------------------------------------------------------------------------------------------------------

	$testSite = $webPage															;Get Special Ticket Prices and things

	$assoretedSearch = StringInStr($testSite, "tableAssortmentList_ySpecial")
	$testSite = StringTrimLeft($testSite, $assoretedSearch)
	MsgBox(0, "Debug - HtmlShow", $testSite)
	$titleSearch = StringInStr($testSite, " title=")
	$testSite = StringTrimLeft($testSite, $titleSearch)

	$titleSearch = StringInStr($testSite, " title=")

	If $titleSearch < 1000 Then
		MsgBox(0, "Debug - TitleSearch", $titleSearch)
		MsgBox(0, "Debug - HtmlShow", $testSite)
		$testSite = StringTrimLeft($testSite, $titleSearch)
	EndIf

     ;------------- HIER NACH GUCKEN MORGEN tableAssortmentList MIT FOR SCHLEIFE DIE DATEN SAUGEN

	MsgBox(0, "Debug - HtmlShow", $testSite)

	$specialTicketName = _StringBetween ($testSite, ">", "<")

	ConsoleWrite(""">")

	MsgBox (0, "Debug Special Ticket Name", $specialTicketName[0])

    ;Option Value 1 = i suchen - Nach links weglöschen - 1 hochrechnen - Wenn keine gefunden mehr - Neue Suche

#ce

EndFunc

#cs
Func updateEvents()

	$webPage = _INetGetSource($eventLink)

	$htmlPage = $webPage														;Splitting the HTML in 2 Parts
																				;Special and Normal Tickets
	$normalTicketInfo = _StringBetween ($htmlPage, "tableAssortmentList_yTix", "</tbody")
	$specialTicketInfo = _StringBetween ($htmlPage, "tableAssortmentList_ySpecial", "</tbody")
																				;tableAssortmentList_ySpecial
	$normalTicketArrayLength = Ubound($normalTicketInfo) -1
	$specialTicketArrayLength = Ubound($specialTicketInfo) -1

	For $i = 0 To $normalTicketArrayLength

		FileWrite($hFileOpenNormal,  @CRLF & $normalTicketInfo[$i] & @CRLF)

	Next

	For $i = 0 To $specialTicketArrayLength

		FileWrite($hFileOpenSpecial,  @CRLF & $specialTicketInfo[$i] & @CRLF)

	Next


EndFunc
#ce



;ConsoleWrite($optionTickets[0] & @CRLF &  $optionTickets[1] & @CRLF  & $optionTickets[2] & @CRLF & $optionTickets[3] & @CRLF & $optionTickets[4])


;MsgBox(0, "Test", $optionOneTickets[0] &" - " & $optionOneTickets[1] &" - " & $optionOneTickets[2] &" - " & $optionOneTickets[3] & " - " & $optionOneTickets[4] & " Karten in Option 5 ")
