make clean && git pull
git log --pretty=format:'%h' -n 1 > gitver
./configure --target=x86_64-win64-gcc --disable-docs --disable-shared
make
gitver=`cat gitver`
7z a av1-git-$gitver-win64.7z *.exe examples/*.exe /usr/bin/msys-2.0.dll /usr/bin/msys-gcc_s-seh-1.dll /usr/bin/msys-stdc++-6.dll nwgat.ninja
rclone copy av1-git-$gitver-win64.7z b2:nwgat-aom