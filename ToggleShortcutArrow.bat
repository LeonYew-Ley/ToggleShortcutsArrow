
@echo off
:: 检查是否以管理员身份运行
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo 正在尝试以管理员权限重新运行...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
setlocal EnableDelayedExpansion
set "regkey=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons"
set "iconvalue=29"
set "customicon=%windir%\System32\shell32.dll,50"

REM 检查当前状态
reg query "%regkey%" /v %iconvalue% >nul 2>nul
if %errorlevel%==0 (
    REM 恢复箭头（删除自定义图标）
    reg delete "%regkey%" /v %iconvalue% /f
    echo 快捷方式箭头已恢复。
) else (
    REM 隐藏箭头（设置自定义图标）
    reg add "%regkey%" /v %iconvalue% /t REG_SZ /d "%customicon%" /f
    echo 快捷方式箭头已隐藏。
)

REM 重启资源管理器使更改生效
taskkill /f /im explorer.exe
start explorer.exe
