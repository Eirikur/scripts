

Edit 5:

Thank you for the great help @LordNeckbeard , now it looks like everything works using your additional output argument command ffmpeg -f v4l2 -framerate 60 -video_size 1280x720 -input_format mjpeg -i /dev/video1 -preset faster -pix_fmt yuv420p out.mkv:

$ ffmpeg -f v4l2 -framerate 60 -video_size 1280x720 -input_format mjpeg -i /dev/video1 -preset faster -pix_fmt yuv420p out.mkv 
ffmpeg version 2.8.11-0ubuntu0.16.04.1 Copyright (c) 2000-2017 the FFmpeg developers
  built with gcc 5.4.0 (Ubuntu 5.4.0-6ubuntu1~16.04.4) 20160609
  configuration: --prefix=/usr --extra-version=0ubuntu0.16.04.1 --build-suffix=-ffmpeg --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --cc=cc --cxx=g++ --enable-gpl --enable-shared --disable-stripping --disable-decoder=libopenjpeg --disable-decoder=libschroedinger --enable-avresample --enable-avisynth --enable-gnutls --enable-ladspa --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libmodplug --enable-libmp3lame --enable-libopenjpeg --enable-libopus --enable-libpulse --enable-librtmp --enable-libschroedinger --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx265 --enable-libxvid --enable-libzvbi --enable-openal --enable-opengl --enable-x11grab --enable-libdc1394 --enable-libiec61883 --enable-libzmq --enable-frei0r --enable-libx264 --enable-libopencv
  libavutil      54. 31.100 / 54. 31.100
  libavcodec     56. 60.100 / 56. 60.100
  libavformat    56. 40.101 / 56. 40.101
  libavdevice    56.  4.100 / 56.  4.100
  libavfilter     5. 40.101 /  5. 40.101
  libavresample   2.  1.  0 /  2.  1.  0
  libswscale      3.  1.101 /  3.  1.101
  libswresample   1.  2.101 /  1.  2.101
  libpostproc    53.  3.100 / 53.  3.100
[mjpeg @ 0x1d6f320] Changeing bps to 8
Input #0, video4linux2,v4l2, from '/dev/video1':
  Duration: N/A, start: 259410.922692, bitrate: N/A
    Stream #0:0: Video: mjpeg, yuvj422p(pc, bt470bg/unknown/unknown), 1280x720, -10 kb/s, 60 fps, 60 tbr, 1000k tbn, 1000k tbc
[swscaler @ 0x1d7e480] deprecated pixel format used, make sure you did set range correctly
[libx264 @ 0x1d72620] using cpu capabilities: MMX2 SSE2Fast SSSE3 SSE4.2 AVX FMA3 AVX2 LZCNT BMI2
[libx264 @ 0x1d72620] profile High, level 3.2
[libx264 @ 0x1d72620] 264 - core 148 r2643 5c65704 - H.264/MPEG-4 AVC codec - Copyleft 2003-2015 - http://www.videolan.org/x264.html - options: cabac=1 ref=2 deblock=1:0:0 analyse=0x3:0x113 me=hex subme=4 psy=1 psy_rd=1.00:0.00 mixed_ref=0 me_range=16 chroma_me=1 trellis=1 8x8dct=1 cqm=0 deadzone=21,11 fast_pskip=1 chroma_qp_offset=0 threads=6 lookahead_threads=1 sliced_threads=0 nr=0 decimate=1 interlaced=0 bluray_compat=0 constrained_intra=0 bframes=3 b_pyramid=2 b_adapt=1 b_bias=0 direct=1 weightb=1 open_gop=0 weightp=1 keyint=250 keyint_min=25 scenecut=40 intra_refresh=0 rc_lookahead=20 rc=crf mbtree=1 crf=23.0 qcomp=0.60 qpmin=0 qpmax=69 qpstep=4 ip_ratio=1.40 aq=1:1.00
Output #0, matroska, to 'out.mkv':
  Metadata:
    encoder         : Lavf56.40.101
    Stream #0:0: Video: h264 (libx264) (H264 / 0x34363248), yuv420p, 1280x720, q=-1--1, 60 fps, 1k tbn, 60 tbc
    Metadata:
      encoder         : Lavc56.60.100 libx264
Stream mapping:
  Stream #0:0 -> #0:0 (mjpeg (native) -> h264 (libx264))
Press [q] to stop, [?] for help
frame=  467 fps= 59 q=-1.0 Lsize=     914kB time=00:00:07.83 bitrate= 955.8kbits/s    
video:910kB audio:0kB subtitle:0kB other streams:0kB global headers:0kB muxing overhead: 0.434447%
[libx264 @ 0x1d72620] frame I:2     Avg QP:21.96  size: 61186
[libx264 @ 0x1d72620] frame P:118   Avg QP:26.01  size:  4695
[libx264 @ 0x1d72620] frame B:347   Avg QP:27.54  size:   734
[libx264 @ 0x1d72620] consecutive B-frames:  0.4%  1.3%  0.6% 97.6%
[libx264 @ 0x1d72620] mb I  I16..4: 14.7% 45.2% 40.0%
[libx264 @ 0x1d72620] mb P  I16..4:  1.4%  3.7%  0.0%  P16..4: 29.9%  4.1%  0.5%  0.0%  0.0%    skip:60.4%
[libx264 @ 0x1d72620] mb B  I16..4:  0.2%  0.4%  0.0%  B16..8:  5.4%  0.2%  0.0%  direct: 4.3%  skip:89.6%  L0:53.4% L1:42.7% BI: 3.9%
[libx264 @ 0x1d72620] 8x8 transform intra:66.4% inter:71.8%
[libx264 @ 0x1d72620] coded y,uvDC,uvAC intra: 38.1% 50.7% 12.7% inter: 2.8% 7.6% 0.1%
[libx264 @ 0x1d72620] i16 v,h,dc,p: 36% 36% 16% 11%
[libx264 @ 0x1d72620] i8 v,h,dc,ddl,ddr,vr,hd,vl,hu: 16% 32% 37%  2%  2%  2%  4%  1%  5%
[libx264 @ 0x1d72620] i4 v,h,dc,ddl,ddr,vr,hd,vl,hu: 18% 46%  8%  2%  3%  3%  4%  3% 12%
[libx264 @ 0x1d72620] i8c dc,h,v,p: 56% 26% 16%  3%
[libx264 @ 0x1d72620] Weighted P-Frames: Y:9.3% UV:7.6%
[libx264 @ 0x1d72620] ref P L0: 58.6% 41.4%
[libx264 @ 0x1d72620] ref B L0: 56.9% 43.1%
[libx264 @ 0x1d72620] ref B L1: 85.5% 14.5%
[libx264 @ 0x1d72620] kb/s:946.85

    ffmpegvideo-capture

Share
Follow
edited Nov 14, 2017 at 19:22
asked Nov 14, 2017 at 18:22
Zorglub29's user avatar
Zorglub29
6,91966 gold badges2020 silver badges3737 bronze badges

    2
    Option placement matters. Move -framerate 60 -video_size 1280x720 before the -i so it applies to the input and not the output. – 
    llogan
    Nov 14, 2017 at 18:25
    Thank you! Now I still get only around 30 fps, but a new warning message: [video4linux2,v4l2 @ 0x1ddc4e0] The driver changed the time per frame from 1/60 to 1/30 Input #0, video4linux2,v4l2, from '/dev/video1':   Duration: N/A, start: 256338.694616, bitrate: 442368 kb/s     Stream #0:0: Video: rawvideo (YUY2 / 0x32595559), yuyv422, 1280x720, 442368 kb/s, 30 fps, 30 tbr, 1000k tbn, 1000k tbc Any idea how to fix this? – 
    Zorglub29
    Nov 14, 2017 at 18:29 

Show output of v4l2-ctl --list-formats-ext. – 
llogan
Nov 14, 2017 at 18:34
see main post (limit in number of characters). – 
Zorglub29
Nov 14, 2017 at 18:35
Which OS? I've had a project where the client encountered this. They upgraded and it went away. – 
Gyan
Nov 14, 2017 at 18:42

Show 6 more comments
1 Answer
Sorted by:
31
Must choose proper format

This camera offers up to 90 fps using its MJPEG encoder, but only up to 30 using raw video, so you have to tell it which format you want with the -input_format input option:

ffmpeg -f v4l2 -framerate 90 -video_size 1280x720 -input_format mjpeg -i /dev/video1 out.mkv
