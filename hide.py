import subprocess
import os

import win32api
import win32con
import win32event
import win32process
from win32com.shell.shell import ShellExecuteEx
from win32com.shell import shellcon

startupinfo = subprocess.STARTUPINFO()
startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW
startupinfo.wShowWindow = SW_HIDE # i.e. 0 you could also try 11 SW_FORCEMINIMIZE
subprocess.call(["msedge.exe", etc], startupinfo = startupinfo)