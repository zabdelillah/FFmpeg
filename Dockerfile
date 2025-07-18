FROM fedora:rawhide
COPY . /src
RUN dnf install -y git make gcc mesa-libGLU mesa-libGLU-devel glew glew-devel glfw-devel nasm diffutils fontconfig-devel fribidi-devel freetype-devel; \
	git clone https://github.com/kbranigan/Simple-OpenGL-Image-Library.git soil; \
	pushd soil; \
	make; make install; \
	popd; \
	pushd src; \
	./configure --extra-libs='-lGLEW -lEGL -lSOIL -lGL -lglfw' --extra-cflags="-I/usr/local/include/SOIL" --extra-ldflags="-L/usr/local/lib" --enable-libfreetype --enable-libfontconfig --enable-libfribidi; \
	make -j16; make install; \
	popd;
	
ENTRYPOINT ["/usr/bin/ffmpeg"]
