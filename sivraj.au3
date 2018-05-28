#include <Misc.au3>
#include <GDIPlus.au3>
#include <WinAPI.au3>
#include <ScreenCapture.au3>
HotKeySet("{f1}","main")

HotKeySet("{f3}","ustaw_uchwyt")
HotKeySet("{f8}","ext")

Global $war
global $licznikZartow=0
$baza="C:\baza audio"
global $status=""
global $czyBylaOdpowiedz=false
global $doTlumaczenia=""
global $wiadomosc=""
global $poprzednia=""
global $tytul="chrome"
Opt("PixelCoordMode",0)

SoundSetWaveVolume(100)
func main()

   while 1
	  Sleep(300)
   record()
Sleep(500)
status()
while $status="s³ucha"
   Sleep(520)
	  status()
	  WEnd
if $status="nie rozumie" or $status="sprawdŸ" Then
    $activeWindow = WinGetHandle("[ACTIVE]")
  ; SoundPlay($baza&"\nie_zrozumialam.wav",1)
   ControlClick($war,"","[CLASS:Chrome_RenderWidgetHostHWND]","left",1,29, 23)
   WinActivate($activeWindow)
else
   Sleep(1200)
  getWiadomosc()
   ConsoleWrite($wiadomosc&@CRLF)
   Sleep(200)
   if $wiadomosc<>$poprzednia then    respond()
   Sleep(400)
EndIf
ConsoleWrite("CYKL>>>>>>>>>>>>>>>>>>>>>>>>>>"&@CRLF)
   WEnd
EndFunc


; <><><>><><><><><><><><><><><><><><><><><><>WYKRYWANIE STATUSU<><><><><><><><><><><><>><><>
func status()
   If MemoryReadPixel(	8+143,85+79,$war)=0x787878 or MemoryReadPixel(	8+137,85+69,$war)=0x777777  Then
	  	  $status="s³ucha"
   ElseIf  MemoryReadPixel(	8+374,85+77,$war)=0x2362D0 then
	  $status="nie rozumie"
	     elseif MemoryReadPixel(8+193,85+86,$war)=0x766ECD Then
	  $status="sprawdŸ"
	    elseif MemoryReadPixel(8+86,85+131,$war)=0xFBBC05 then
	  $status="czeka"
   Elseif MemoryReadPixel(8+682,85+45,$war)=0x656565 then
	  $status=""
	  EndIf
	  consolewrite("STATUS: "&$status&@CRLF)
   EndFunc

Func MemoryReadPixel($x, $y, $handle)
   Local $hDC
   Local $iColor
   Local $sColor

   $hDC = _WinAPI_GetWindowDC($handle)
   $iColor = DllCall("gdi32.dll", "int", "GetPixel", "int", $hDC, "int", $x, "int", $y)
   $sColor = Hex($iColor[0], 6)
   _WinAPI_ReleaseDC($handle, $hDC)

   Return "0x" & StringRight($sColor, 2) & StringMid($sColor, 3, 2) & StringLeft($sColor, 2)
EndFunc   ;==>MemoryReadPixel



func wyswietlNapis()
   $h=guicreate("",700,400)
   $respond=""
switch $doTlumaczenia
 Case "woda"
	 $respond="water"
 Case "zdjêcie"
	 $respond="image"
 Case "krzes³o"
	 $respond="chair"
 Case "pies"
	 $respond="dog"
 Case "kot"
	 $respond="cat"
 Case "samochód"
	 $respond="car"
 Case "ryba"
	 $respond="fish"
 Case "butelka"
	 $respond="bottle"
 Case "szczêœcie"
	 $respond="programming"
  EndSwitch
  SoundPlay($baza&"\"&$respond&".wav")
   $l=guictrlcreateLabel($respond,10,10,680,390)
   GUICtrlSetFont ( $l, 60)
   guisetstate(@SW_SHOW,$h)
   Sleep(5000)
   guidelete($h)

   EndFunc
;ODPOWIEDZ REAKCJA ODZEW CZYNNOSC KROK DZIALANIE PROCEDURA ZABIEG RIPOSTA EFEKT AKCJA

func respond()
ConsoleWrite("RESPOND "&$wiadomosc&@CRLF)
if stringleft ($wiadomosc,21)="Jak jest po angielsku" then
     $doTlumaczenia=StringRight($wiadomosc,StringLen($wiadomosc)-22)
   wyswietlNapis()
   $czyBylaOdpowiedz=true
   EndIf
if StringLeft($wiadomosc,6)="Napisz" and $wiadomosc<>"Napisz maila"then
   Sleep(1000)
   send(Stringright($wiadomosc,Stringlen($wiadomosc)-7)&" ")
     $czyBylaOdpowiedz=true
   EndIf
switch $wiadomosc

case "impreza"
$gui=GUICreate("hehe",@DesktopWidth+10,@DesktopHeight+20)
$guig=GUICtrlCreateGraphic(0,0,@DesktopWidth+10,@DesktopHeight+20)
guisetstate(@SW_SHOW ,$gui)
SoundPlay($baza&"\houseparty.wav")

for $i=0 to 140
GUICtrlSetBkColor($guig,0x000000)
Sleep(50)
GUICtrlSetBkColor($guig,0xFFFFFF)
Sleep(50)
Next
GUIDelete($gui)
case "w³¹cz facebooka"
   send("{LSHIFT DOWN}")
   ShellExecute("chrome.exe", "www.facebook.com","","")
    send("{LSHIFT up}")
case "Jak wysoka jest Wie¿a Eiffla"
     SoundPlay($baza&"\eiffla.wav",1)
  case "Ile lat ma Statua Wolnoœci"
	 SoundPlay($baza&"\statuawolnosci.wav",1)
  case "Gdzie le¿y Sosnowiec"
	 SplashImageOn("",$baza&"\sosnowiec.jpg",1000,800)
	  SoundPlay($baza&"\tutaj.wav",1)
	  Sleep(6000)
	  Splashoff()
case "Opowiedz kawa³"
   if $licznikZartow<4 then
  SoundPlay($baza&"\suchar"&$licznikZartow&".wav",1)
  else
    SoundPlay($baza&"\nieznamwiecejzartow.wav",1)
 endif
 $licznikZartow+=1
case "notatnik"
  run("notepad.exe")

case "w³¹cz notatnik"
  run("notepad.exe")

  case "odpal notatnik"
  run("notepad.exe")

  case "muszê zrobiæ notatki"
  run("notepad.exe")

  case "kalkulator"
  run("calc.exe")

    case "odpal kalkulator"
  run("calc.exe")

  case "w³¹cz kalkulator"
  run("calc.exe")


    case "zamknij kalkulator"
  processclose("calc.exe")

    case "zamknij notatnik"
  processclose("notepad.exe")
case "Napisz maila"
   run($baza&"\sendmail.exe")
  ; sleep(1000)
  ; While ProcessExists("sendmail.exe")<>@error
	;  sleep(100)
	;  guigetmsg()
	;  WEnd
  case "Zagraj coœ na pianinie"
	 grajnapianinie()

  Case "Dziêki za pomoc"
	   SoundPlay($baza&"\dozobaczenia.wav",1)
	   sleep(100)
	   SoundPlay($baza&"\glosujciena.wav",1)

Case "czeœæ"
   SoundPlay($baza&"\przedstawsie.wav",1)

case "która godzina"
   godzina()

case else
   if $czyBylaOdpowiedz=false then    SoundPlay($baza&"\niepomoge.wav",1)
EndSwitch
$poprzednia=$wiadomosc
 ;$wiadomosc=""
$czyBylaOdpowiedz=false
EndFunc


; AIR ON  AIR ON  AIR ON  AIR ON  AIR ON  AIR ON  AIR ON  AIR ON  AIR ON  AIR ON  AIR ON
func record()
 Sleep(50)
 $activeWindow = WinGetHandle("[ACTIVE]")
 ControlClick($war,"","[CLASS:Chrome_RenderWidgetHostHWND]","left",1,697,42)
 WinActivate($activeWindow)
   Sleep(100)
EndFunc


;					WIADOMOSC TYTUL BELKA CHROME OKNO CZYTANIE INTERAKCJA STRINGI
func getWiadomosc()

   $title=wingettitle($war)
   $tytul=$title
$mes=StringLeft($title,Stringlen($title)-34)
if($mes=$wiadomosc) then
   $wiadomosc=""
   Else
   $wiadomosc=$mes
EndIf

   sleep(10)
   EndFunc


;           								UCHWYT NA KUBEK
func ustaw_uchwyt()
   $war=wingethandle("[ACTIVE]")
    winmove($war,"",default,default,795,527)
   EndFunc

;											ZEGAR CLOCK CLK
Func godzina()

SoundPlay($baza&"\jest.wav",1)
if @hour = 0 Then SoundPlay($baza&"\0m.wav",1)
if @hour = 1 Then SoundPlay($baza&"\1.wav",1)
if @hour = 2 Then SoundPlay($baza&"\2.wav",1)
if @hour = 3 Then SoundPlay($baza&"\3.wav",1)
if @hour = 4 Then SoundPlay($baza&"\4.wav",1)
if @hour = 5 Then SoundPlay($baza&"\5.wav",1)
if @hour = 6 Then SoundPlay($baza&"\6.wav",1)
if @hour = 7 Then SoundPlay($baza&"\7.wav",1)
if @hour = 8 Then SoundPlay($baza&"\8.wav",1)
if @hour = 9 Then SoundPlay($baza&"\9.wav",1)
if @hour = 10 Then SoundPlay($baza&"\10.wav",1)
if @hour = 11 Then SoundPlay($baza&"\11.wav",1)
if @hour = 12 Then SoundPlay($baza&"\12.wav",1)
if @hour = 13 Then SoundPlay($baza&"\13.wav",1)
if @hour = 14 Then SoundPlay($baza&"\14.wav",1)
if @hour = 15 Then SoundPlay($baza&"\15.wav",1)
if @hour = 16 Then SoundPlay($baza&"\16.wav",1)
if @hour = 17 Then SoundPlay($baza&"\17.wav",1)
if @hour = 18 Then SoundPlay($baza&"\18.wav",1)
if @hour = 19 Then SoundPlay($baza&"\19.wav",1)
if @hour = 20 Then SoundPlay($baza&"\20.wav",1)
if @hour = 21 Then SoundPlay($baza&"\21.wav",1)
if @hour = 22 Then SoundPlay($baza&"\22.wav",1)
if @hour = 23 Then SoundPlay($baza&"\23.wav",1)
   ;minuty >>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>

if @min =00  then  SoundPlay($baza&"\0m.wav",1)
if @min =01  then  SoundPlay($baza&"\1m.wav",1)
if @min =02  then  SoundPlay($baza&"\2m.wav",1)
if @min =03  then  SoundPlay($baza&"\3m.wav",1)
if @min =04  then  SoundPlay($baza&"\4m.wav",1)
if @min =05  then  SoundPlay($baza&"\5m.wav",1)
if @min =06  then  SoundPlay($baza&"\6m.wav",1)
if @min =07  then  SoundPlay($baza&"\7m.wav",1)
if @min =08  then  SoundPlay($baza&"\8m.wav",1)
if @min =09  then  SoundPlay($baza&"\9m.wav",1)
if @min =11  then  SoundPlay($baza&"\11m.wav",1) ;
if @min =12  then  SoundPlay($baza&"\12m.wav",1) ;
if @min =13  then  SoundPlay($baza&"\13m.wav",1) ;
if @min =14  then  SoundPlay($baza&"\14m.wav",1) ;
if @min =15  then  SoundPlay($baza&"\15m.wav",1)
if @min =16  then  SoundPlay($baza&"\16m.wav",1) ;
if @min =17  then  SoundPlay($baza&"\17m.wav",1) ;
if @min =18  then  SoundPlay($baza&"\18m.wav",1) ;
if @min =19  then  SoundPlay($baza&"\19m.wav",1) ;
   if @min =10  then  SoundPlay($baza&"\10m.wav",1)
   if @min =20  then  SoundPlay($baza&"\20m.wav",1)
   if @min =30  then  SoundPlay($baza&"\30m.wav",1)
   if @min =40  then  SoundPlay($baza&"\40m.wav",1)
   if @min =50  then  SoundPlay($baza&"\50m.wav",1)

   ;<><><><><><><><><><><><>dok³adne <><><><><><><><><><><><><><><><><><><><><><><><><>
if @min =21  then
   SoundPlay($baza&"\20m.wav",1)
   SoundPlay($baza&"\1m.wav",1)
endif

if @min =22  then
   SoundPlay($baza&"\20m.wav",1)
   SoundPlay($baza&"\2m.wav",1)
endif

if @min =23  then
   SoundPlay($baza&"\20m.wav",1)
   SoundPlay($baza&"\3m.wav",1)
endif

if @min =24  then
   SoundPlay($baza&"\20m.wav",1)
   SoundPlay($baza&"\4m.wav",1)
endif

if @min =25  then
   SoundPlay($baza&"\20m.wav",1)
   SoundPlay($baza&"\5m.wav",1)
endif

if @min =26  then
   SoundPlay($baza&"\20m.wav",1)
   SoundPlay($baza&"\6m.wav",1)
endif

if @min =27  then
   SoundPlay($baza&"\20m.wav",1)
   SoundPlay($baza&"\7m.wav",1)
endif

if @min =28  then
   SoundPlay($baza&"\20m.wav",1)
   SoundPlay($baza&"\8m.wav",1)
endif

if @min =29  then
   SoundPlay($baza&"\20m.wav",1)
   SoundPlay($baza&"\9m.wav",1)
endif

if @min =31  then
   SoundPlay($baza&"\30m.wav",1)
   SoundPlay($baza&"\1m.wav",1)
endif

if @min =32  then
   SoundPlay($baza&"\30m.wav",1)
   SoundPlay($baza&"\2m.wav",1)
endif

if @min =33  then
   SoundPlay($baza&"\30m.wav",1)
   SoundPlay($baza&"\3m.wav",1)
endif

if @min =34  then
   SoundPlay($baza&"\30m.wav",1)
   SoundPlay($baza&"\4m.wav",1)
endif

if @min =35  then
   SoundPlay($baza&"\30m.wav",1)
   SoundPlay($baza&"\5m.wav",1)
endif

if @min =36  then
   SoundPlay($baza&"\30m.wav",1)
   SoundPlay($baza&"\6m.wav",1)
endif

if @min =37  then
   SoundPlay($baza&"\30m.wav",1)
   SoundPlay($baza&"\7m.wav",1)
endif

if @min =38  then
   SoundPlay($baza&"\30m.wav",1)
   SoundPlay($baza&"\8m.wav",1)
endif

if @min =39  then
   SoundPlay($baza&"\30m.wav",1)
   SoundPlay($baza&"\9m.wav",1)
endif

if @min =41  then
   SoundPlay($baza&"\40m.wav",1)
   SoundPlay($baza&"\1m.wav",1)
endif

if @min =42  then
   SoundPlay($baza&"\40m.wav",1)
   SoundPlay($baza&"\2m.wav",1)
endif

if @min =43  then
   SoundPlay($baza&"\40m.wav",1)
   SoundPlay($baza&"\3m.wav",1)
endif

if @min =44  then
   SoundPlay($baza&"\40m.wav",1)
   SoundPlay($baza&"\4m.wav",1)
endif

if @min =45  then
   SoundPlay($baza&"\40m.wav",1)
   SoundPlay($baza&"\5m.wav",1)
endif

if @min =46  then
   SoundPlay($baza&"\40m.wav",1)
   SoundPlay($baza&"\6m.wav",1)
endif

if @min =47  then
   SoundPlay($baza&"\40m.wav",1)
   SoundPlay($baza&"\7m.wav",1)
endif

if @min =48  then
   SoundPlay($baza&"\40m.wav",1)
   SoundPlay($baza&"\8m.wav",1)
endif

if @min =49  then
   SoundPlay($baza&"\40m.wav",1)
   SoundPlay($baza&"\9m.wav",1)
endif

if @min =51  then
   SoundPlay($baza&"\50m.wav",1)
   SoundPlay($baza&"\1m.wav",1)
endif

if @min =52  then
   SoundPlay($baza&"\50m.wav",1)
   SoundPlay($baza&"\2m.wav",1)
endif

if @min =53  then
   SoundPlay($baza&"\50m.wav",1)
   SoundPlay($baza&"\3m.wav",1)
endif

if @min =54  then
   SoundPlay($baza&"\50m.wav",1)
   SoundPlay($baza&"\4m.wav",1)
endif

if @min =55  then
   SoundPlay($baza&"\50m.wav",1)
   SoundPlay($baza&"\5m.wav",1)
endif

if @min =56  then
   SoundPlay($baza&"\50m.wav",1)
   SoundPlay($baza&"\6m.wav",1)
endif

if @min =57  then
   SoundPlay($baza&"\50m.wav",1)
   SoundPlay($baza&"\7m.wav",1)
endif

if @min =58  then
   SoundPlay($baza&"\50m.wav",1)
   SoundPlay($baza&"\8m.wav",1)
endif

if @min =59  then
   SoundPlay($baza&"\50m.wav",1)
   SoundPlay($baza&"\9m.wav",1)
endif

EndFunc


func ext()
Exit
EndFunc

func grajnapianinie()
Send("^t")
sleep(100)
Send("http://www.apronus.com/music/flashpiano.htm")
Send("{ENTER}")
Sleep(6000)
$a=200
$b=500
Send("{o}")
Sleep($a)
Send("{9}")
Sleep($a)
Send("{o}")
Sleep($a)
Send("{9}")
Sleep($a)
Send("{o}")
Sleep($a)
Send("{y}")
Sleep($a)
Send("{i}")
Sleep($a)
Send("{u}")
Sleep($a)
Send("{t}")
Sleep($b)

Send("{Tab}")
Sleep($a)
Send("{w}")
Sleep($a)
Send("{t}")
Sleep($a)
Send("{y}")
Sleep($b)

Send("{w}")
Sleep($a)
Send("{5}")
Sleep($a)
Send("{y}")
Sleep($a)
Send("{u}")
Sleep($b)

Send("{w}")
Sleep($a)
Send("{o}")
Sleep($a)
Send("{9}")
Sleep($a)
Send("{o}")
Sleep($a)
Send("{9}")
Sleep($a)
Send("{o}")
Sleep($a)
Send("{y}")
Sleep($a)
Send("{i}")
Sleep($a)
Send("{u}")
Sleep($a)
Send("{t}")
Sleep($b)

Send("{Tab}")
Sleep($a)
Send("{w}")
Sleep($a)
Send("{t}")
Sleep($a)
Send("{y}")
Sleep($b)

Send("{Tab}")
Sleep($a)
Send("{u}")
Sleep($a)
Send("{y}")
Sleep($a)
Send("{t}")
Sleep($b)
Send("{o}")
Sleep($a)
Send("{u}")
Sleep($a)
Send("{i}")
Sleep($a)
Send("{o}")
Sleep($a)
Send("{r}")
Sleep(2*$a)
Send("{p}")
Sleep($a)
Send("{o}")
Sleep($a)
Send("{i}")
Sleep(2*$a)
Send("{e}")
Sleep($a)
Send("{o}")
Sleep($a)
Send("{i}")
Sleep($a)
Send("{u}")
Sleep($a)
Send("{w}")
Sleep($a)
Send("{i}")
Sleep($a)
Send("{u}")
Sleep($a)
Send("{y}")
Sleep($a)
Send("{w}")
Sleep($a)
Send("{o}")
Sleep(1000)
Send("^w")

   EndFunc

while 1

   WEnd