#
# Copyright (c) Microsoft. All rights reserved.
# Licensed under the MIT license. See LICENSE.md file in the project root for full license information.
#
# Microsoft Cognitive Services Speech SDK - Quickstart for Linux and C++
#
# Check out https://aka.ms/csspeech for documentation.
#

SPEECHSDK_ROOT:=/home/yuichii/speechsdk

CHECK_FOR_SPEECHSDK := $(shell test -f $(SPEECHSDK_ROOT)/lib/x64/libMicrosoft.CognitiveServices.Speech.core.so && echo Success)
ifneq ("$(CHECK_FOR_SPEECHSDK)","Success")
  $(error Please set SPEECHSDK_ROOT to point to your extracted Speech SDK, $$SPEECHSDK_ROOT/lib/x64/libMicrosoft.CognitiveServices.Speech.core.so should exist.)
endif

# If you'd like to build for 32-bit Linux, replace "x64" in the next line with "x86".
TARGET_PLATFORM:=x64
LIBPATH:=$(SPEECHSDK_ROOT)/lib/$(TARGET_PLATFORM)

INCPATH:=$(SPEECHSDK_ROOT)/include/cxx_api $(SPEECHSDK_ROOT)/include/c_api

LIBS:=-lMicrosoft.CognitiveServices.Speech.core -lpthread -l:libssl.so.1.0.0 -l:libcurl.so.4 -l:libasound.so.2

all: helloworld

# Note: to run, LD_LIBRARY_PATH should point to $LIBPATH.
helloworld: helloworld.cpp
	g++ $< -o $@ \
	    --std=c++14 \
	    $(patsubst %,-I%, $(INCPATH)) \
	    $(patsubst %,-L%, $(LIBPATH)) \
	    $(LIBS)
