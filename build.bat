@echo off

set config=Release
set platform=AnyCpu
:: Use current directory
set cwd=%CD%
:: Switch disk and folder
cd /D ^"%cwd%^"
:: Use current dirrectory for output directory
set outputdir=%cwd%\dlls
set commonflags=/p:Configuration=%config% /p:Platform=%platform% /p:DebugSymbols=false

set fdir=%WINDIR%\Microsoft.NET\Framework
set msbuild=%fdir%\v4.0.30319\msbuild.exe

:build
echo ---------------------------------------------------------------------
echo Compile started...
::Add quotes for folderw with spaces
pause
::.NET Framework 2.0: /p:DebugType=None not working, /p:DebugType=full or /p:DebugType=pdbonly, so no specify /p:DebugType here to disable this.
%msbuild% "src\Fleck2.csproj" %commonflags% /tv:2.0 /p:TargetFrameworkVersion=v2.0 /p:OutputPath="%outputdir%\dll-for-NET20"
pause

::.NET Framework 3.5
%msbuild% "src\Fleck2.csproj" %commonflags% /p:DebugType=None /tv:3.5 /p:TargetFrameworkVersion=v3.5 /p:OutputPath="%outputdir%\dll-for-NET35"
pause

::.NET Framework 4.0
%msbuild% "src\Fleck2.csproj" %commonflags% /p:DebugType=None /tv:4.0 /p:TargetFrameworkVersion=v4.0 /p:OutputPath="%outputdir%\dll-for-NET40"
pause

:: After compile for .NET Framework 4.0 this will working for net40. This is compilation demo with dll.
%msbuild% "demo_with_dll\Fleck2.Demo.csproj" /property:Configuration=Release /p:IntermediateOutputPath="../demo_with_dll/bin/Release/"
pause

::.NET Framework 4.0
%msbuild% "src\Fleck2.csproj" %commonflags% /p:DebugType=None /tv:4.0 /p:TargetFrameworkVersion=v4.5 /p:OutputPath="%outputdir%\dll-for-NET45"
pause
::Need two recompilations on .NET Framework 4.0 to get dll-files for net20 and net35

:: Flack without dll, no need dll, and does not matter the .NET Framework version of last dll.
%msbuild% "demo_without_dll\Fleck2.Demo.csproj" /property:Configuration=Release /p:IntermediateOutputPath="../demo_without_dll/bin/Release/"
pause

:done
echo.
echo ---------------------------------------------------------------------
echo Compile finished....
goto exit

:exit
::Don't exit, to be able to read errors.
pause