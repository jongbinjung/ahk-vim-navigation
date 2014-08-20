; ahk-vim-navigation.ahk
; Written by Jongbin Jung
;
; Incorporated some script from Model_Vim.ahk
; Written by Rich Alesi
; and Modified for AHK_L by Andrej Mitrovic
; (http://www.autohotkey.com/board/topic/41206-modal-vim/)
; 
; Update (08/16/2014)
; Simplified script to take modifiers into account
; (see, http://www.autohotkey.com/board/topic/83755
; -using-an-arbitrary-key-as-a-modifier-without-sacrificing-it/)

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Global variables
inputNumber := " "

; Notification GUI {{{
notify(text, time = 2000)
{
    #IfWinExist VIM-Mode commands
        resetGUI()
    #IfWinExist
    ; Set the flags for OSD
    Gui, 90:+AlwaysOnTop -Caption +ToolWindow +Disabled -SysMenu +Owner
    ; Add and set the OSD Text
    Gui, 90:Font, s10 bold
    Gui, 90:Add, Text, cAA0000, %text%
    ; OSD Background Color (Black)
    Gui, 90:Color, 000000
    Gui, 90:Show,NoActivate xCenter yCenter, VIM-Mode commands
    Sleep, %time%
    Gui, 90:Destroy
    return
} ;}}}

; HotKey to Initiate VI-mode with Double-tap of Esc {{{
$Esc::
    If (A_PriorHotKey = "$Esc" AND A_TimeSincePriorHotKey < 500)
    {                                
        ; Set the flags for OSD
        Gui, 99:+AlwaysOnTop -Caption +ToolWindow +Disabled -SysMenu +Owner
        ; Add and set the OSD Text
        Gui, 99:Font, s15 bold
        Gui, 99:Add, Text, cAA0000, VI-Mode Activated (Esc to Exit)
        ; OSD Background Color (Black)
        Gui, 99:Color, 000000
        Gui, 99:Show,NoActivate x0 y10, VIM-Mode Activated
    }
    Else
    {
        SendInput {Esc}
    }
Return ; }}}

#IfWinExist VIM-Mode Activated ; {{{

    ; ESC ends VIM-mode
    ESC:: 
    {
        if (inputNumber != " ")
        {
            resetInputNumber()
            return
        }
        else
        {
            endVIM()
            return
        }
    }

    ; i(nput) end VIM-mode
    i::
    {
        endVIM()
        return
    }

    ; Other input modes ...
    +i:: 
    {
        SendInput {Home}
        endVIM()
        return
    }
    a::
    {
        SendInput {Right}
        endVIM()
        return
    }
    +a::
    {
        SendInput {End}
        endVIM()
        return
    }

    ; cursor movements
    h:: 
    {
        SendInput {Left %inputNumber%}
        resetInputNumber()
        return
    }
    j:: 
    {
        SendInput {Down %inputNumber%}
        resetInputNumber()
        return
    }
    k:: 
    {
        SendInput {Up %inputNumber%}
        resetInputNumber()
        return
    }
    l:: 
    {
        SendInput {Right %inputNumber%}
        resetInputNumber()
        return
    }

    ; page movements
    w:: 
    {
        SendInput ^{Right %inputNumber%}
        resetInputNumber()
        return
    }
    b:: 
    {
        SendInput ^{Left %inputNumber%}
        resetInputNumber()
        return
    }
    x:: 
    {
        SendInput {Delete %inputNumber%}
        resetInputNumber()
        return
    }
    0:: ; Add to the inputNumber if inputNumber != null, otherwise HOME
    {
        if (inputNumber != " ")
        {
            inputNumber = %inputNumber%0
            normalize(0)
            notify(inputNumber)
            return
        }
        else
        {
            SendInput {Home}
            resetInputNumber()
            return
        }
    }
    -:: 
    {
        SendInput {End}
        resetInputNumber()
        return
    }
    $:: 
    {
        SendInput {End}
        resetInputNumber()
        return
    }

    ; selection movements with Shift
    +h:: 
    {
        SendInput +{Left %inputNumber%}
        resetInputNumber()
        return
    }
    +j:: 
    {
        SendInput +{Down %inputNumber%}
        resetInputNumber()
        return
    }
    +k:: 
    {
        SendInput +{Up %inputNumber%}
        resetInputNumber()
        return
    }
    +l::
    {
        SendInput +{Right %inputNumber%}
        resetInputNumber()
        return
    }
    +w:: 
    {
        SendInput +^{Right %inputNumber%}
        resetInputNumber()
        return
    }
    +b:: 
    {
        SendInput +^{Left %inputNumber%}
        resetInputNumber()
        return
    }
    +x:: 
    {
        SendInput +{Delete}
        resetInputNumber()
        return
    }
    ):: 
    {
        SendInput +{Home}
        resetInputNumber()
        return
    }
    _:: 
    {
        SendInput +{End}
        resetInputNumber()
        return
    }

    ; Copy (Yank) / Cut (Delete) / Paste (Put)
    y:: 
    {
        SendInput ^c
        resetInputNumber()
        return
    }
    p:: 
    {
        SendInput ^v
        resetInputNumber()
        return
    }
    d:: 
    {
        SendInput ^x
        resetInputNumber()
        return
    }

    ; Search with /
    /::
    {
        SendInput ^f
        resetInputNumber()
        return
    }

    ; HotKey to VIM maps
    u:: 
    {
        SendInput ^z
        resetInputNumber()
        return
    }

    ; Catch numbers to repeat commands
    $1::
    {
       inputNumber = %inputNumber%1
       normalize(1)
       notify(inputNumber)
       return
    }

    $2::
    {
       inputNumber = %inputNumber%2
       normalize(2)
       notify(inputNumber)
       return
    }

    $3::
    {
       inputNumber = %inputNumber%3
       normalize(3)
       notify(inputNumber)
       return
    }

    $4::
    {
       inputNumber = %inputNumber%4
       normalize(4)
       notify(inputNumber)
       return
    }

    $5::
    {
       inputNumber = %inputNumber%5
       normalize(5)
       notify(inputNumber)
       return
    }

    $6::
    {
       inputNumber = %inputNumber%6
       normalize(6)
       notify(inputNumber)
       return
    }

    $7::
    {
       inputNumber = %inputNumber%7
       normalize(7)
       notify(inputNumber)
       return
    }

    $8::
    {
       inputNumber = %inputNumber%8
       normalize(8)
       notify(inputNumber)
       return
    }

    $9::
    {
       inputNumber = %inputNumber%9
       normalize(9)
       notify(inputNumber)
       return
    }
        
#IfWinExist ;}}}

;;; Ad-hoc Vi navigation with Space + key combo {{{
; Use 'Space' as a modifier to activate simple vi keybindings
; (inspired by Simple Vi Mode v2 of Karabiner for Mac)

Space & F1::Return
; send explicitly when no other key is pressed before release
*Space::SendInput {Blind}{Space}
 ; KeyDown:=A_TickCount
 ; KeyWait Space
 ; if (A_TickCount-KeyDown < 400)
     ; Send {Space}
 ; Return

#If GetKeyState("Space", "p")

; cursor movements
 h::left 
 j::down 
 k::up 
 l::right 

; page movements
 w::^right
 b::^left 
 x::delete 
 0::home 
 -::end 
 $::end 


; HotKey to VIM maps
 u:: SendInput ^z

; Change file name
 i:: SendInput {F2}

#If

; }}}

; Validate the inputNumber and make sure that it's less than 500 {{{
normalize(resetNumber)
{
    global inputNumber
    if (inputNumber > 500)
    {
        inputNumber := resetNumber
    }
} ;}}}

; Reset the inputNumber to " "
resetInputNumber()
{
   global
   resetGUI()
   inputNumber := " "
   return
}

resetGUI()
{
    Gui, 90:Destroy
    return
}
endVIM()
{
    Gui, 99:Destroy
    resetInputNumber()
    return
}

