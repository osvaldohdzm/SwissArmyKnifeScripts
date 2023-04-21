#
# Script to keep the PC alive, will prevent screen lock and sleep.
# Works by pressing Print Screen every 2 minutes, side effect is that a screenshot will overwrite the clipboard contents
#
clear host

Write-Host '                                                ::*-:             :=+     '
Write-Host '                   %                            -=-%=            =+++=    '
Write-Host '                %%%                             -=-=++-       :=*=---*    '
Write-Host '           %%%%..                               *-*=-+#***-::-*+-----*    '
Write-Host '         %%%/%    %                            -%*:---::::+****--:++:*    '
Write-Host '        &%%%%%    %%                        =*#+:------------=#**@@#=+    '
Write-Host '          &%%%%%   %%,                    -#---:::--------------#@+:==:   '
Write-Host '              (%%%%                      :*---+*##------==-------=++=-+   '
Write-Host '                  %.                     -=--:##@+----=*+@*=-------*%-+:  '
Write-Host '                                         *------------++@@#=--------=*+*  '
Write-Host ' %&&&&%###&&@@@@@@@@@@@@#               ==-*=#%#--------==----::::----=*  '
Write-Host ' %&&&&%###&&@@@@@@@@@@@@&%&&&#          +=#-+%#*@=:-++-------::::::----+: '
Write-Host ' %&&&&%%#%&&@@@@@@@@@@@@@@     @@*      *=++@#@%*=+::::------:::::::---=+ '
Write-Host ' %&@&&%%#%&&@@@@@@@@@@@&(        &@     #-:=+++ :-##==*-----::::::::----+ '
Write-Host ' %&&&&&%#%&&@@@@@@@@@@@&/        &@     *-----+**+++*+-------::::::----=- '
Write-Host ' %&&&&&%%%&@@@@@@@@@@@@&*        @@     ==-------===----------::::-----*  '
Write-Host ' %&&&&&%%%&@@@@@@@@@@@@&,        &&      *----------------------------+:  '
Write-Host ' #&&&&&%%%&@@@@@@@@@@@@&/      ,&&       -*=--------------------=-----+   '
Write-Host ' %&&&&&%%%&@@@@@@@@@@@@@@@%&@@&&          :=*=---------------=*-+=--=*:   '
Write-Host ' %&&&&&%%%&@@@@@@@@@@@&&                   -***+::::::-###***+:-::+*-     '
Write-Host ' .&@&&&&&&&@@@@@@@@@@&&&...               -=--:=******+:::---=**++-       '
Write-Host '                                          =:::::::-----------:::          '



write-warning "Your PC will not go to sleep whilst this window is open..."
Do {
[void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
[System.Windows.Forms.SendKeys]::SendWait("{CAPSLOCK}")
[System.Windows.Forms.SendKeys]::SendWait("{CAPSLOCK}")

Start-Sleep -Seconds 120

} While ($true)