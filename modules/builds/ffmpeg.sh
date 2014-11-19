# install ffmpeg deps
sudo apt-get -y install autoconf automake build-essential libass-dev libfreetype6-dev libgpac-dev \
  libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev \
  libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev

sudo apt-get install yasm
sudo apt-get install libx264-dev

# additional libraries could be added here ( libmp3lame / libvpm / libopus )
apt-get install libfdk-aac-dev

# get source
git clone git://source.ffmpeg.org/ffmpeg.git ffmpeg

cd ffmpeg
sudo make
sudo make install

# TODO: should be symlink
cp /root/bin/ffmpeg /usr/bin/ffmpeg

cd ..
cd ffmpeg

# configure and make
PATH="$PATH:$HOME/bin" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/ffmpeg_build" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" \
  --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --bindir="$HOME/bin" \
  --enable-gpl \
  --enable-libass \
  --enable-libfreetype \
  --enable-libtheora \
  --enable-libfdk-aac \
  --enable-libvorbis \
  --enable-libx264 \
  --enable-nonfree \
  --enable-x11grab
  
  
#  --enable-libvpx \
#  --enable-libmp3lame \
#  --enable-libopus \
