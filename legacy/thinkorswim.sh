#!/bin/bash
# 17 July 2012  hacked from emacs.sh
# Crude fix for the startup hang issue on Mint/Cinnamon Jan 2015
# Now just kill thinkTDA processes, not all Java processes, March 2015'

/usr/lib/jvm/zulu-8-amd64/jre/bin/java -Dinstall4j.jvmDir=/usr/lib/jvm/zulu-8-amd64/jre/bin/java \
                                       -Dexe4j.moduleName=~/Applications/thinkorswim/thinkorswim -Dwhitelabel=tos \
                                       -Dinstall4j.launcherId=18 -Dinstall4j.swt=false -Di4jv=0 -Di4jv=0 \
                                       -Di4jv=0 -Di4jv=0 -Di4jv=0 -Xmx768m -Xms32m \
                                       -Djava.util.Arrays.useLegacyMergeSort=true -Dawt.useSystemAAFontSettings=lcd_hrgb \
                                       -Dsun.net.http.allowRestrictedHeaders=true -Di4j.vpt=true \
                                       -classpath ~/Applications/thinkorswim/.install4j/i4jruntime.jar:~/Applications/thinkorswim/launcher.jar \
                                       com.install4j.runtime.launcher.UnixLauncher launch 8ee4fbfc ~/Applications/thinkorswim/client.out \
                                       ~/Applications/thinkorswim/client.out com.devexperts.jnlp.Launcher
