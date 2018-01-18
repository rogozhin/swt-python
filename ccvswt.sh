#!/usr/bin/env bash

buildMac(){
	gcc -march=x86-64 -fpic \
		-c ccvswt.c ccvswt_wrap.c \
		   ccv_algebra.c ccv_basic.c ccv_cache.c ccv_classic.c \
		   ccv_io.c ccv_memory.c ccv_output.c ccv_resample.c ccv_sift.c \
		   ccv_swt.c ccv_transform.c ccv_util.c \
		./3rdparty/sha1/sha1.c \
		-I/System/Library/Frameworks/Python.framework/Versions/2.7/include/python2.7

	gcc -dynamiclib -march=x86-64 \
		ccvswt.o ccvswt_wrap.o \
		ccv_algebra.o ccv_basic.o ccv_cache.o ccv_classic.o ccv_io.o \
		ccv_memory.o  ccv_resample.o ccv_sift.o ccv_swt.o \
		ccv_transform.o ccv_util.o sha1.o \
		-ljpeg -lpython2.7 \
		-o _ccvswt.so
}

buildLinux(){
	gcc -fpic \
		-c ccvswt.c ccvswt_wrap.c \
		   ccv_algebra.c ccv_basic.c ccv_cache.c ccv_classic.c ccv_io.c \
		   ccv_memory.c ccv_output.c ccv_resample.c ccv_sift.c ccv_swt.c \
		   ccv_transform.c ccv_util.c \
		./3rdparty/sha1/sha1.c \
		-I/usr/include/python2.7

	ld -shared \
		ccvswt.o ccvswt_wrap.o \
		ccv_algebra.o ccv_basic.o ccv_cache.o ccv_classic.o ccv_io.o \
		ccv_memory.o ccv_output.o ccv_resample.o ccv_sift.o ccv_swt.o \
		ccv_transform.o ccv_util.o sha1.o \
		-ljpeg \
		-o _ccvswt.so
}

swig -python ccvswt.i

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)
		buildLinux
		;;
    Darwin*)
		buildMac
		;;
    *)
		echo "WARN unstested env"
		buildLinux
esac

mkdir ccvswt
cp _ccvswt* ccvswt/
cp ccvswt.* ccvswt/
cp ccvswt_* ccvswt/
touch ccvswt/__init__.py

echo "Done. Copy ccvswt dir into you project"
