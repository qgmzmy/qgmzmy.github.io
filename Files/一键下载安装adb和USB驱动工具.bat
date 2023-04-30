@echo off
cls
title  一键配置ADB环境

echo ================================
echo         一键配置ADB环境
echo ================================

::提权Admin
echo 正在提权
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("powershell.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

color 02

echo.

::下载platform-tools
echo ==========安装platform-tools============
echo 正在下载
set curpath=C:\
cd /d %curpath%
set zipname=platform-tools-latest-windows.zip
set downurl=https://dl.google.com/android/repository/platform-tools-latest-windows.zip?hl=zh-cn
powershell Invoke-WebRequest -Uri "%downurl%" -OutFile "%zipname%"

::解压
echo 正在解压
@REM tar -xzvf platform-tools-latest-windows.zip
powershell  Expand-Archive -Force -Path platform-tools-latest-windows.zip -DestinationPath C:\

@REM ::复制
@REM md C:\platform-tools
@REM xcopy platform-tools C:\platform-tools

::删除文件
del /f C:\platform-tools-latest-windows.zip
@REM rmdir /s /q platform-tools

::添加环境变量
echo 正在添加到环境变量
@REM setx Path "%PATH%;C:\platform-tools"
powershell $addPath=‘C:\platform-tools’; $target=‘Machine’ ; $path = [Environment]::GetEnvironmentVariable(‘Path’, $target); $newPath = $path + ‘;’ + $addPath; [Environment]::SetEnvironmentVariable(“Path”, $newPath, $target)

echo.
::安装usb驱动
echo ===============安装usb驱动=============
echo 正在下载驱动
powershell Invoke-WebRequest -Uri "https://dl.google.com/android/repository/usb_driver_r13-windows.zip?hl=zh-cn" -OutFile "GoogleUSBDriver.zip"

echo 正在解压驱动
mkdir C:\tr-tmp
powershell  Expand-Archive -Force -Path GoogleUSBDriver.zip -DestinationPath C:\tr-tmp
pnputil -i -a C:\tr-tmp\usb_driver\*.inf

echo 正在进行最后的处理
del /f /s /q C:\tr-tmp

echo 完成！
echo 按回车退出
set /p exit=