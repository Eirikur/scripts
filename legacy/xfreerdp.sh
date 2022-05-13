#!/bin/bash
# D forgo window decor -f fullscreen -z compress -x l assume lan bandwidth
xfreerdp -o -D -g 1920x1200 -u eh -p eh123dragon -z -x l  192.168.0.3


# XFREERDP(1)                        xfreerdp                        XFREERDP(1)



# NAME
#        xfreerdp - FreeRDP X11 client
# SYNOPSIS
#        xfreerdp [options] server[:port] [[options] server[:port] ...]

# DESCRIPTION
#        xfreerdp is an X11 Remote Desktop Protocol (RDP) client which is part
#        of the FreeRDP project. An RDP server is built-in to many editions of
#        Windows. Alternative servers included xrdp and VRDP (VirtualBox).

# OPTIONS
#        -0
#            Attach to the admin console of the server.

#        -a bpp
#            Sets the color depth for the connection to bpp bits per pixel.
#            Valid values are 8, 15, 16, 24 and 32. The default value is the
#            color depth of the FreeRDP-window.

#        -c dir
#            Sets the working-dir to dir. This parameter is only used when an
#            AlternateShell (-s shell) is requested.  dir should contain the
#            executable file specified in the AlternateShell.

#        -D
#            Removes the windows decorations.

#        -d
#            Domain used in authentication.

#        -f
#            start in full screen mode. This mode can always be en- and disabled
#            using Ctrl-Alt-Enter.

#        -T text
#            Sets the window title to text.

#        -g geometry
#            Sets the size of the FreeRDP window (and of the remote desktop,
#            when establishing a new connection).  geometry can have one of the
#            following forms:

#            ·    WxH - in this case the resulting window will be of WxH pixels.

#            ·    P% - in this case the resulting window will be P% of your
#                screen.

#            ·   The special keyword workarea - in this case the resulting
#                window will be of the same size as your workarea.


#        -k id
#            Sets the keyboard-layout-id to id.

#        -m
#            Don't send mouse motion events.

#        -n hostname
#            Set the reported client hostname to hostname. Default is to
#            automatically detect the hostname.

#        -o
#            Play audio on the console instead of redirecting to the client.

#        -p password
#            Password used in authentication.

#        -s shell
#            Sets the startup-shell to shell. This parameter should contain a
#            complete path to the alternate shell. If the alternete shell
#            requires a different working directory use -c dir.

#        -t port
#            Connect to port, instead of the default 3389.

#        -u username
#            Username used in authentication.

#        -x flag
#            Set the experiance performance flags.  flag can be one of:

#            ·   m - (modem): Equivalent to 15.

#            ·   b - (broadband): Equivalent to 1.

#            ·   l - (lan): Equivalent to 0.

#            ·    num - A hexadecimal number that represents a bit-mask, were
#                numbers mean the following [1]:

#                ·   1: Disable desktop wallpaper.

#                ·   2: Disable full-window drag (only the window outline is
#                    displayed when the window is moved).

#                ·   4: Disable menu animations.

#                ·   8: Disable user interface themes.

#                ·   20: Disable mouse cursor shadows.

#                ·   40: Disable cursor blinking.

#                ·   80: Enable font smoothing.

#                ·   100: Enable Desktop Composition.



#        -z
#            Enable compression.

#        --app
#            initialize a RemoteApp connection. This implies -g workarea.

#        --ext
#            load an extension

#        --no-auth
#            Skips authentication. This is useful e.g. for the current FreeRDP
#            server that doesn't yet support server-side authentication.

#        --from-stdin
#            Prompts for unspecified arguments -u username, -p password, -d
#            domain and connection host. This is useful to hide arguments from
#            ps. Also useful for scripts that will feed these arguments to the
#            client via (what else?) stdin.

#        --no-fastpath
#            Disables fast-path. Use slow-path packets instead, which have
#            larger headers. It might be good for debugging certain issues when
#            you suspect it might be linked to the parsing of one of the two
#            header types.

#        --gdi
#            GDI rendering backend.  backend can be either sw (software) or hw
#            (hardware).

#        --no-osb
#            Disable off screen bitmaps.

#        --no-bmp-cache
#            Disable bitmap cache.

#        --plugin
#            load a plugin

#        --rfx
#            Enable RemoteFX.

#        --rfx-mode
#            RemoteFX operational flags.  flags can be either v[ideo], i[mage]),
#            default is video.

#        --nsc
#            Enable NSCodec.

#        --disable-wallpaper
#            Disable wallpaper.

#        --composition
#            Enable composition (RDVH only, not to be confused with remote
#            composition).

#        --disable-full-window-drag
#            Disable full window drag.

#        --disable-menu-animations
#            Disable menu animations.

#        --disable-theming
#            Disable theming.

#        --no-rdp
#            Disable Standard RDP encryption.

#        --no-tls
#            Disable TLS encryption.

#        --no-nla
#            Disable network level authentication.

#        --sec proto
#            force protocol security.  proto can be one of rdp, tls or nla.

#        --ntlm
#            force NTLM protocol version.  version can be one of 1 or 2.

#        --ignore-certificate
#            ignore verification of logon certificate.

#        --version
#            Print version information.

# LINKS
#        http://www.freerdp.com/

# AUTHOR
#        The FreeRDP Team

# NOTES
#         1. Taken from MS-RDPBCGR Section 2.2.1.11.1.1.1 - Extended Info Packet

#         2. MS-RDPBCGR Section 2.2.1.11.1.1.1 - Extended Info Packet
#            http://msdn.microsoft.com/en-us/library/cc240476%28v=prot.10%29.aspx



# freerdp                           2011-08-27                       XFREERDP(1)

# FreeRDP - A Free Remote Desktop Protocol Client
# See http://www.freerdp.com for more information

# Usage: xfreerdp [options] server:port
#   -0: connect to console session
#   -a: set color depth in bit, default is 16
#   -c: initial working directory
#   -D: hide window decorations
#   -T: window title
#   -d: domain
#   -f: fullscreen mode
#   -g: set geometry, using format WxH or X% or 'workarea', default is 1024x768
#   -h: print this help
#   -k: set keyboard layout ID
#   -K: do not interfere with window manager bindings
#   -m: don't send mouse motion events
#   -n: hostname
#   -o: console audio
#   -p: password
#   -s: set startup-shell
#   -t: alternative port number, default is 3389
#   -u: username
#   -x: performance flags (m[odem], b[roadband] or l[an])
#   -X: embed into another window with a given XID.
#   -z: enable compression
#   --app: RemoteApp connection. This implies -g workarea
#   --ext: load an extension
#   --no-auth: disable authentication
#   --from-stdin: unspecified username, password, domain and hostname params are prompted
#   --no-fastpath: disable fast-path
#   --gdi: graphics rendering (hw, sw)
#   --no-osb: disable offscreen bitmaps
#   --no-bmp-cache: disable bitmap cache
#   --plugin: load a virtual channel plugin
#   --rfx: enable RemoteFX
#   --rfx-mode: RemoteFX operational flags (v[ideo], i[mage]), default is video
#   --nsc: enable NSCodec (experimental)
#   --disable-wallpaper: disables wallpaper
#   --composition: enable desktop composition
#   --disable-full-window-drag: disables full window drag
#   --disable-menu-animations: disables menu animations
#   --disable-theming: disables theming
#   --no-rdp: disable Standard RDP encryption
#   --no-tls: disable TLS encryption
#   --no-nla: disable network level authentication
#   --ntlm: force NTLM authentication protocol version (1 or 2)
#   --ignore-certificate: ignore verification of logon certificate
#   --sec: force protocol security (rdp, tls or nla)
#   --secure-checksum: use salted checksums with Standard RDP encryption
#   --version: print version information

