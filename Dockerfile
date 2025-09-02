FROM nvidia/cuda:13.0.0-devel-ubuntu24.04
COPY . /src
RUN apt-get update; apt-get install -y \
		git \
		make \
		gcc \
		libglu1-mesa-dev \
		libglew-dev \
		libglfw3-dev \
		nasm \
		diffutils \
		libfontconfig1-dev \
		libfribidi-dev \
		libfreetype6-dev \
		libharfbuzz-dev \
		libx264-dev \
		yasm cmake libtool libc6 libc6-dev unzip wget libnuma1 libnuma-dev \
		libx265-dev; \
	git clone https://github.com/kbranigan/Simple-OpenGL-Image-Library.git soil; \
	cd soil; \
	make; make install; \
	cd ..; \
	git clone https://github.com/FFmpeg/nv-codec-headers.git \
	cd nv-codec-headers; \
	make; make install; \
	cd ..; \
	cd src; \
        ./configure --enable-opengl --enable-gpl --enable-libharfbuzz --enable-libx264 --enable-libx265 --extra-libs='-lpthread -lm -lGLEW -lEGL -lglfw -lSOIL -lGL' --extra-cflags="-I/usr/local/include/SOIL" --extra-ldflags="-L/usr/local/lib" --enable-libfreetype --enable-libfontconfig --enable-libfribidi --enable-nonfree --enable-cuda-nvcc --enable-libnpp --enable-cuda --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64 --nvccflags="-gencode arch=compute_75,code=sm_75 -O2" --disable-static --enable-shared; \
	make -j16; make install; \
	cd ..;
	
ENTRYPOINT ["/usr/local/bin/ffmpeg"]
