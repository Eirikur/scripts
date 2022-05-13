#!/bin/bash

MY_REVISION=$(grep "Revision" < /proc/cpuinfo 2>/dev/null | awk '{print $3}')
ENCODED=$((0x${MY_REVISION} >> 23 & 1))
  if [[ ${ENCODED} = 1 ]]
  then
    PCB_REVISION=("v1.0" "v1.1" "v1.2" "v1.3" "v1.4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")
    MODEL_NAME=("A" "B" "A+" "B+" "Pi2B" "Alpha" "CM1" "unknown" "3B" "Zero" "CM3" "unknown" "Zero W" "3B+" "3A+" "internal use only" "CM3+" "4B" "18 ?" "400" "CM4")
    PROCESSOR=("BCM2835" "BCM2836" "BCM2837" "BCM2711" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")
    MANUFACTURER=("Sony UK" "Egoman" "Embest" "Sony Japan" "Embest" "Stadium" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")
    MEMORY_SIZE=("256 MB" "512 MB" "1024 MB" "2048 MB" "4096 MB" "8192 MB" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")
    ENCODED_FLAG=("" "revision is a bit field")
    WARRANTY_VOID_OLD=("" "warranty void - Pre Pi2")
    WARRANTY_VOID_NEW=("" "warranty void - Post Pi2")

    # Save these for later, should we need to make decisions based on model, ram, etc.
    MY_PCB_REVISION=${PCB_REVISION[$((0x${MY_REVISION}&0xf))]}
    MY_MODEL_NAME=${MODEL_NAME[$((0x${MY_REVISION}>>4&0xff))]}
    MY_PROCESSOR=${PROCESSOR[$((0x${MY_REVISION}>>12&0xf))]}
    MY_MANUFACTURER=${MANUFACTURER[$((0x${MY_REVISION}>>16&0xf))]}
    MY_MEMORY_SIZE=${MEMORY_SIZE[$((0x${MY_REVISION}>>20&7))]}
    MY_ENCODED_FLAG=${ENCODED_FLAG[$((0x${MY_REVISION}>>23&1))]}
    MY_WARRANTY_VOID_OLD=${WARRANTY_VOID_OLD[$((0x${MY_REVISION}>>24&1))]}
    MY_WARRANTY_VOID_NEW=${WARRANTY_VOID_NEW[$((0x${MY_REVISION}>>25&1))]}
  fi

  items="MY_PCB_REVISION MY_MODEL_NAME MY_PROCESSOR MY_MANUFACTURER MY_MEMORY_SIZE MY_ENCODED_FLAG MY_WARRANTY_VOID_OLD MY_WARRANTY_VOID_NEW"

  

  
