# small example howto cmake

## env
```shell
sudo apt-get install rpm
```

## 带内核模块，需要安装kernel-devel
```shell
cd build
cmake ..
make
#build rpm;deb
make package
```
