FROM fedora:rawhide
COPY . /src
RUN dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm; dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm; \
	dnf install -y git make gcc mesa-libGLU mesa-libGLU-devel glew glew-devel glfw-devel nasm diffutils fontconfig-devel fribidi-devel freetype-devel harfbuzz-devel x264 x264-devel x265 x265-devel ; \
	git clone https://github.com/kbranigan/Simple-OpenGL-Image-Library.git soil; \
	pushd soil; \
	make; make install; \
	popd; \
	pushd src; \
        ./configure --enable-opengl --enable-gpl --enable-libharfbuzz --enable-libx264 --enable-libx265 --extra-libs='-lpthread -lm -lGLEW -lEGL -lglfw -lSOIL -lGL' --extra-cflags="-I/usr/local/include/SOIL" --extra-ldflags="-L/usr/local/lib" --enable-libfreetype --enable-libfontconfig --enable-libfribidi; \
	make -j16; make install; \
	popd;
	
ENTRYPOINT ["/usr/bin/ffmpeg"]
