@echo off
cls
title  һ������ADB����

echo ================================
echo         һ������ADB����
echo ================================

::��ȨAdmin
echo ������Ȩ
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("powershell.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

color 02

echo.

::����platform-tools
echo ==========��װplatform-tools============
echo ��������
set curpath=C:\
cd /d %curpath%
set zipname=platform-tools-latest-windows.zip
set downurl=https://dl.google.com/android/repository/platform-tools-latest-windows.zip?hl=zh-cn
powershell Invoke-WebRequest -Uri "%downurl%" -OutFile "%zipname%"

::��ѹ
echo ���ڽ�ѹ
@REM tar -xzvf platform-tools-latest-windows.zip
powershell  Expand-Archive -Force -Path platform-tools-latest-windows.zip -DestinationPath C:\

@REM ::����
@REM md C:\platform-tools
@REM xcopy platform-tools C:\platform-tools

::ɾ���ļ�
del /f C:\platform-tools-latest-windows.zip
@REM rmdir /s /q platform-tools

::��ӻ�������
echo ������ӵ���������
@REM setx Path "%PATH%;C:\platform-tools"
powershell $addPath=��C:\platform-tools��; $target=��Machine�� ; $path = [Environment]::GetEnvironmentVariable(��Path��, $target); $newPath = $path + ��;�� + $addPath; [Environment]::SetEnvironmentVariable(��Path��, $newPath, $target)

echo.
::��װusb����
echo ===============��װusb����=============
echo ������������
powershell Invoke-WebRequest -Uri "https://dl.google.com/android/repository/usb_driver_r13-windows.zip?hl=zh-cn" -OutFile "GoogleUSBDriver.zip"

echo ���ڽ�ѹ����
mkdir C:\tr-tmp
powershell  Expand-Archive -Force -Path GoogleUSBDriver.zip -DestinationPath C:\tr-tmp
pnputil -i -a C:\tr-tmp\usb_driver\*.inf

echo ���ڽ������Ĵ���
del /f /s /q C:\tr-tmp

echo ��ɣ�
echo ���س��˳�
set /p exit=