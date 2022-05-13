# Make a project directory, check out the sources from svn, build and install.



mkdir lssvn
cd lssvn

sudo apt install subversion

svn co https://svn.linuxsampler.org/svn/libgig/trunk libgig
svn co https://svn.linuxsampler.org/svn/linuxsampler/trunk linuxsampler
# sudo apt-get install g++ debhelper pkg-config automake libtool fakeroot libsndfile1-dev doxygen uuid-dev lv2core lv2-dev
sudo apt-get install g++ debhelper pkg-config automake libtool fakeroot libsndfile1-dev doxygen uuid-dev lv2-dev

cd libgig
dpkg-buildpackage -rfakeroot -b
cd ..


sudo dpkg -i libgig*.deb
sudo dpkg -i gigtools_*.deb
# sudo dpkg -i libgig-dev_*.deb




sudo apt-get install bison libjack-jackd2-dev flex dssi-dev libsqlite3-dev
cd linuxsampler

 # Apply patch from Steveb
 rm -rf rpi_linuxsampler_patch
 git clone https://github.com/steveb/rpi_linuxsampler_patch.git
 if ! patch -R -p0 --dry-run < rpi_linuxsampler_patch/linuxsampler-arm.patch
 then
   patch -p1 < rpi_linuxsampler_patch/linuxsampler-arm.patch
 fi


dpkg-buildpackage -rfakeroot -b
# make parser
# dpkg-buildpackage -rfakeroot -b
cd ..

# Final install
sudo dpkg -i liblinuxsampler_*.deb
sudo dpkg -i liblinuxsampler-dev_*.deb
sudo dpkg -i linuxsampler_*.deb
