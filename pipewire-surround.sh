#!/bin/bash

pw-cli create-node adapter '{ factory.name=support.null-audio-sink node.name=hrir-headphones media.class=Audio/Sink object.linger=1 audio.position=[FL,BL,SL,FC,FR,BR,SR,LFE] }'

