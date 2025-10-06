@echo off

set BUILDDIR=%CD%/cqbuild
set INSTALLDIR=%CD%/cqinstall
cmake -S . -B %BUILDDIR% -DC_API=1
cd %BUILDDIR%
cmake --build . --config Debug
cmake --build . --config Release
cmake --install . --prefix %INSTALLDIR%
cd ..