#!/bin/sh

set -e

( [ -z "$1" ] || [ -z "$2" ] ) && {
cat << EOF
usage:  x-cursor-big  [scale_integer]  [misc|Type1] 
descr:  misc tries to scale using misc/, removing Type1/ hack if applied
        Type1/ tries to scale using alias and removes misc hack if applied
        \$FONTDIR is the location of X fonts/ where ./misc/ is found
        (the script only knows of hacks it previously applied)
	either seems to work in freebsd13, i prefer "misc"
EOF
exit
}

[ -z "$FONTDIR" ] &&  [ -d /usr/local/share/fonts ] && \
  FONTDIR="/usr/local/share/fonts"

[ -e $FONTDIR/$2 ]

pkg install pcf2bdf bdfresize bdftopcf

case "$2" in

Type1)

  cd $FONTDIR/Type1
  ( [ -e fonts.alias ] && [ ! -e fonts.alias.ok ] ) && {
cat << EOF
I dont know how to deal with a pre-existing Type1/fonts.alias
EOF
    exit
  }

  #  changes needed in misc/

  [ -e cd $FONTDIR/misc/ ] && {

    cd $FONTDIR/
    cd misc/
    mkdir -p tmp/bak
    [ ! -e tmp/bak/fonts.dir ] && \
      cp fonts.dir tmp/bak/
    [ ! -e tmp/bak/cursor.pcf.gz ] && \
      cp *cursor*.gz tmp/bak/

cat << EOF | ed -s
r fonts.dir
/^cursor/
.,.d
w fonts.dir
q
EOF

    rm cursor* || true
    rm olcursor* || true
    # when fonts.dir changes
    mkfontdir .
  }

  # changes needed in Type1/

  cd $FONTDIR/
  cd Type1/
  touch fonts.alias.ok
cat << EOF > fonts.alias
cursor -xfree86-cursor-medium-r-normal--0-${1}-0-0-p-0-adobe-fontspecific
EOF
  fc-cache -r
  echo "Please run the following an X session is running:"
  echo "# xset fp rehash"

  ;;

*)

  [ -e $FONTDIR/Type1/fonts.alias ] && {
    cd $FONTDIR/Type1
    rm fonts.alias || true
    fc-cache -r
  }

  cd $FONTDIR/
  cd misc/
  mkdir -p tmp/bak/
  [ ! -e tmp/bak/fonts.dir ] && \
    cp fonts.dir tmp/bak/
  [ -e tmp/bak/fonts.dir ] && \
    cp tmp/bak/fonts.dir .

for cur in cursor olcursor
do
  cd $FONTDIR/
  cd misc/
  [ ! -e tmp/bak/$cur.pcf.gz ] && cp $cur.pcf.gz tmp/bak/
  cd tmp/
  cp bak/$cur.pcf.gz .
  gzip -d $cur.pcf.gz
  pcf2bdf $cur.pcf > $cur.bdf
  bdfresize -f $1 $cur.bdf > $cur.big.bdf
  bdftopcf $cur.big.bdf > $cur.big.pcf
  cp $cur.big.pcf ../$cur.pcf
  cd ..
  rm $cur.pcf.gz || true
  gzip $cur.pcf
done

  cd $FONTDIR/
  cd misc/
  mkfontdir .

;;

esac

exit


# despite that both work i'm unsure if both at once work:  it could be that
#   xset -fp  controls cursor selection misc v. Type1

# other methods are:
#   see manpage Xcursor , realize programs might do custom things and
#      all efforts might be for naught
#   use (kde) settings
#   use xset  IF you have pre-requisite files
#   use .Xresources (again, if you have ~/.icons)
#   remove this file entirely if Type1/  has cursors
#      and also add alias in Type1/ to make cursor bigger if needed
#      requires changing font files to reflect these changes
#   somehow use /etc/fonts.conf - idkh  
# what doesnt seem to work:
#    xsetroot -cursor cursor-big.pcf  "not a cursor (bmp) file"
#    and many other internet advices

# there is a pitfall that 1.5x or 2x is in no way guaranteed to be the
#   the hight of fonts in an application.  its really the apps job to
#   use an appropriate cursor not X because apps change font size

# this will come in handy
#   export QT_SCALE_FACTOR="2.5"

# furthermore:  freebsd doesn't use Ubuntu's xorg install structure and
#   it DOES NOT install all resoruces, like  rbg.txt
#   this means some (old) apps may not be able to find resources (ie, Motif)
#   and that if links are made so they can be found certain apps will act
#   differently / better

# https://unix.stackexchange.com/questions/236159/bigger-x11-cursors-suitable-for-4k-screens

