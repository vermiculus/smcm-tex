rem Windows version of the makefile
rem for all you Windoze users out there. :)

@ECHO off

rem Get TEXMFHOME as variable
for /f "skip=1" %%a in ('kpsewhich -var-value TEXMFHOME') do if not defined TEXMFHOME set TEXMFHOME=%%a
PLAYTEX=%TEXMFHOME%/tex/latex/playtex

if %1 == default goto :default
if %1 == install goto :install
if %1 == tikzpgf goto :tikzpgf
if %1 == clean   goto :clean
if %1 == show    goto :show

:default
echo <Insert directions on how to use this script>
goto :end

:tikzpgf
echo Installing TikZ/PGF version 3.0
if not exist %TEXMFHOME% mkdir %TEXMFHOME%
echo How do I unzip things?
goto :end

:install
echo Installing style files
if not exist %PLAYTEX% mkdir %PLAYTEX%
copy exam-extensions.sty %PLAYTEX%
copy smcm-danda.sty %PLAYTEX%
copy smcm-math.sty %PLAYTEX%
goto :end

:clean
echo Cleaning junk files
echo <Nothing to do>
goto :end

:show
echo TEXMFHOME=%TEXMFHOME%
echo PLAYTEX=%PLAYTEX%

:end

rem Local Variables:
rem mode: dos
rem truncate-lines: nil
rem End:
