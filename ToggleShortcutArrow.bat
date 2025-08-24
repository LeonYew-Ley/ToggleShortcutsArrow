::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWH3eyGE/LBJaSzSQM2G/BaEP1Mr6++mPnnkSU+UzfbzT1aaaI/UH+WT2Z5k66m5ImcUfHBpKexy/IAY3pg4=
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFDdRTRaMAE+1EbsQ5+n//NaTp14JaNYwf4jX34eGL/IH6VDwZtgozn86
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983

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
set "customicon=%~dp0transparent.ico"


REM 检查当前状态
reg query "%regkey%" /v %iconvalue% >nul 2>nul
if %errorlevel%==0 (
    REM 恢复箭头（删除自定义图标）
    reg delete "%regkey%" /v %iconvalue% /f
    echo 快捷方式箭头已恢复。
) else (
    REM 隐藏箭头（设置为运行目录下的透明图标）
    reg add "%regkey%" /v %iconvalue% /t REG_SZ /d "%customicon%" /f
    echo 快捷方式箭头已隐藏（已设置为透明图标）。
)

REM 提供选项，是否现在重启资源管理器
echo 操作已完成。更改将在重启资源管理器或注销后生效。
set /p restartChoice=是否现在重启资源管理器？(Y/N): 
if /i "%restartChoice%"=="Y" (
    taskkill /f /im explorer.exe
    start explorer.exe
    echo 资源管理器已重启。
) else (
    echo 未重启资源管理器，稍后可手动重启或注销。
)
