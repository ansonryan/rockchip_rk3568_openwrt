# Photonicat 2 - 新一代便携智能路由器

<div align="center">
<img src="https://photonicat.com/images/thumb/d/d7/Pcat2-wiki.webp/1200px-Pcat2-wiki.webp.png?20250822110422" alt="Photonicat 2" width="350" height="350"/>
</div>

Photonicat 2，在原有基础上进行了多方面的增强与升级：

🖥️ **CPU 升级**：由原来的 4 核升级为 8 核，采用先进的 8nm RK3678 SoC，计算性能和能效全面提升。

🧠 **内存升级**：由 DDR4 升级为 LPDDR5 内存，支持 On-Die ECC，自修复能力更强，数据稳定性更高。

📡 **天线增强**：内置7根增强型天线，支持4根可扩展外置天线，信号更强。

🔋 **电池升级**：内置 4 × 18650 大容量电池，续航能力显著提升。

🔌 **电源系统升级**：支持 无电池运行（直流供电模式），并新增 双向快充 30W 功能，既可快速自充，也可作为移动电源反向输出。

💾 **存储扩展**：除 eMMC/SD 外，新增对 NVMe 固态硬盘的支持，提供高速存储能力。

📺 **新增交互**：内置屏幕，可实时显示设备状态和网络信息。

📊 **传感器扩展**：集成库仑计（Columb Meter），支持精确电流/电量测量；G-sensor 提供移动检测与姿态感应。

🛠️ **软件兼容**：保持 OpenWRT 开源支持，灵活安装丰富插件，同时可刷入 Debian、Ubuntu、Android 固件

---

## 支持设备

本源码支持 Photonicat v1 和 v2 设备，专为便携智能路由器优化。

1. https://photonicat.com/
2. https://photonicat.com/wiki

## 注意

1. **不要用 root 用户进行编译**
2. 国内用户编译前最好准备好梯子
3. 默认登录IP 172.16.0.1 密码 photonicat

## 编译命令

1. 首先装好 Linux 系统，推荐 Debian 13或 Ubuntu 24.04 LTS

2. 安装编译依赖

   ```bash
   sudo apt update -y
   sudo apt full-upgrade -y
   sudo apt install -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
   bzip2 ccache clang cmake cpio curl device-tree-compiler flex gawk gcc-multilib g++-multilib gettext \
   genisoimage git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libfuse-dev libglib2.0-dev \
   libgmp3-dev libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libpython3-dev \
   libreadline-dev libssl-dev libtool llvm lrzsz msmtp ninja-build p7zip p7zip-full patch pkgconf \
   python3 python3-pyelftools python3-setuptools qemu-utils rsync scons squashfs-tools subversion \
   swig texinfo uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev
   ```

3. 下载源代码，更新 feeds 并选择配置

   ```bash
   git clone https://github.com/coolsnowwolf/lede
   cd lede
   ./scripts/feeds update -a
   ./scripts/feeds install -a
   make menuconfig
   ```

4. 下载 dl 库，编译固件
（-j 后面是线程数，第一次编译推荐用单线程）

   ```bash
   make download -j8
   make V=s -j1
   ```

本套代码保证肯定可以编译成功。里面包括了 R24 所有源代码，包括 IPK 的。

你可以自由使用，但源码编译二次发布请注明我的 GitHub 仓库链接。谢谢合作！

二次编译：

```bash
cd lede
git pull
./scripts/feeds update -a
./scripts/feeds install -a
make defconfig
make download -j8
make V=s -j$(nproc)
```

如果需要重新配置：

```bash
rm -rf .config
make menuconfig
make V=s -j$(nproc)
```

编译完成后输出路径：bin/targets

### 使用 WSL/WSL2 进行编译

由于 WSL 的 PATH 中包含带有空格的 Windows 路径，有可能会导致编译失败，请在 `make` 前面加上：

```bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

由于默认情况下，装载到 WSL 发行版的 NTFS 格式的驱动器将不区分大小写，因此大概率在 WSL/WSL2 的编译检查中会返回以下错误：

```txt
Build dependency: OpenWrt can only be built on a case-sensitive filesystem
```

一个比较简洁的解决方法是，在 `git clone` 前先创建 Repository 目录，并为其启用大小写敏感：

```powershell
# 以管理员身份打开终端
PS > fsutil.exe file setCaseSensitiveInfo <your_local_lede_path> enable
# 将本项目 git clone 到开启了大小写敏感的目录 <your_local_lede_path> 中
PS > git clone https://github.com/coolsnowwolf/lede <your_local_lede_path>
```

> 对已经 `git clone` 完成的项目目录执行 `fsutil.exe` 命令无法生效，大小写敏感只对新增的文件变更有效。

### macOS 原生系统进行编译

1. 在 AppStore 中安装 Xcode

2. 安装 Homebrew：

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. 使用 Homebrew 安装工具链、依赖与基础软件包：

   ```bash
   brew unlink awk
   brew install coreutils diffutils findutils gawk gnu-getopt gnu-tar grep make ncurses pkg-config wget quilt xz
   brew install gcc@11
   ```

4. 然后输入以下命令，添加到系统环境变量中：

   - intel 芯片的 mac

   ```bash
   echo 'export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"' >> ~/.bashrc
   echo 'export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"' >> ~/.bashrc
   echo 'export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"' >> ~/.bashrc
   echo 'export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"' >> ~/.bashrc
   echo 'export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"' >> ~/.bashrc
   echo 'export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"' >> ~/.bashrc
   echo 'export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"' >> ~/.bashrc
   ```

   - apple 芯片的 mac

   ```zsh
   echo 'export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"' >> ~/.bashrc
   echo 'export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"' >> ~/.bashrc
   echo 'export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"' >> ~/.bashrc
   echo 'export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"' >> ~/.bashrc
   echo 'export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"' >> ~/.bashrc
   echo 'export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"' >> ~/.bashrc
   echo 'export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"' >> ~/.bashrc
   ```

5. 重新加载一下 shell 启动文件 `source ~/.bashrc`，然后输入 `bash` 进入 bash shell，就可以和 Linux 一样正常编译了
