REM set your WiX path
SET PATH=%PATH%;"C:\Program Files (x86)\WiX Toolset v3.11\bin";"C:\Program Files (x86)\Windows Kits\10\bin\x64\";
SET ARCH=x64

REM sign nomacs
signtool sign /f "..\..\TU-code-signing.p12"  /t http://timestamp.digicert.com .\nomacs.%ARCH%\nomacs.exe

REM harvest dlls
heat.exe dir .\nomacs.%ARCH% -o HarvestedFiles.wxs -scom -frag -srd -sreg -gg -cg ApplicationResources -dr BIN_DIR_REF

REM create meta object
candle.exe -arch %ARCH% nomacs-setup.wxs nomacs-ui.wxs HarvestedFiles.wxs

REM make setup (should take a few seconds)
light.exe -ext WixUIExtension nomacs-setup.wixobj nomacs-ui.wixobj HarvestedFiles.wixobj -b ./nomacs.%ARCH% -out nomacs-setup.msi

REM sign the setup
signtool sign /f "..\..\TU-code-signing.p12"  /t http://timestamp.digicert.com .\nomacs-setup.msi

REM clean up
del *.wixobj
del *.wixpdb