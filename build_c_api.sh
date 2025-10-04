#!/bin/bash

export BUILDDIR=$PWD/cqbuild
export INSTALLDIR=$PWD/cqinstall
cmake -S . -B $BUILDDIR -DC_API=1
cd $BUILDDIR
cmake --build . --config Debug
cmake --build . --config Release
cmake --install . --prefix $INSTALLDIR
cd ..
