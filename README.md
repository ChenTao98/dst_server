# 饥荒联机版云服务器部署

部署云服务器是在Ubuntu 18.04 系统下进行的，默认已有云服务器并且对linux系统操作具有一定基础的条件下进行的。使用的是steam下的饥荒联机版

本人云服务器配置2核2G，带宽1M，系统盘40G

## 安装前准备
+ 先对系统软件进行更新

    ```shell
    sudo apt-get update

    sudo apt-get upgrade

    sudo apt-get install libstdc++6:i386 libgcc1:i386 libcurl4-gnutls-dev:i386 libstdc++6 libgcc1 libcurl4-gnutls-dev screen
    ```

+ 下载本库中的运行脚本，并修改运行权限。修改权限可以使用命令。运行脚本暂时可以单独存放
    ```shell
    chmod 777 *.sh
    ```

## 安装steam与dst

+ 安装steam，本教程默认steam的安装目录为/home/steam/, 若有修改安装路径，后续脚本也需要修改，所以建议不改安装路径
    ```shell
    cd /home && mkdir steam && cd steam && mkdir dst cmd && cd cmd && wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz

    tar -xvzf steamcmd_linux.tar.gz
    ```

+ 安装与更新dst,更新脚本问update_starve.sh, 首次安装运行时，会下载steam和dst，所需时间较长，后续更新所花时间较短。注意脚本中的路径，如有修改，请自行修改。

    ```shell
    ./update_starve.sh
    ```
## 初始化dst存档文件夹
+ 安装完dst之后，预期dst安装目录为/home/steam/dst，需要将下载的脚本复制到dst目录下。目标目录为/home/steam/dst/bin. 可以参考命令
    ```shell
    cp *.sh /home/steam/dst/bin

    cp *.cmd /home/steam/dst/bin
    ```
+ 安装完dst之后，需要进行初始化一下存档存放位置
    ```shell
    cd /home/steam/dst/bin

    ./dontstarve_dedicated_server_nullrenderer -console -cluster Cluster_1 -shard Master
    ```

+ 运行命令之后可以在输出日志看到存档位置。正常存在当前用户目录下，例如/home/cur_user/.klei/dontStarveTogether。如果root用户，在/root/.klei/dontStarveTogether

## 存档复制
+ 在本地创建新的世界，进入之后退出，生成存档。存档位置可以通过游戏内  管理世界-打开世界文件夹 查看。例如需要复制的存档路径为 a/b/Cluster_1/

+ 生成服务器token：
    + 在游戏内，左下角点击账户进入klei官网
    + 然后依次 游戏 -- 饥荒联机版游戏服务器 -- 添加新服务器，随便输入名称，即可以生成服务器
    + 在存档目录下新建存储token文件，路径为 a/b/Cluster_1/cluster_token.txt，复制生成的服务器token并黏贴到新文件

+ 上传存档：前面新建世界的存档文件夹 a/b/Cluster_1/ 上传到云服务器的存档文件夹下，正常存在当前用户目录下，例如/home/cur_user/.klei/dontStarveTogether。如果root用户，在/root/.klei/dontStarveTogether

## mod安装
+ 打开本地世界存档文件夹，寻找mod列表文件，文件通常位置为 a/b/Cluster_1/Master/modoverrides.lua
+ 查看世界使用的mod，mod 以id显示，例如["workshop-1185229307"] ["workshop-1378549454"]，其中的数字表示mod的id

+ 打开云服务器mod安装列表，路径为 /home/steam/dst/mods/dedicated_server_mods_setup.lua

+ 将安装的mod添加到文件中，每个mod需要添加两行内容，以mod 1185229307，1378549454为例，需要添加如下内容：
    ```
    ServerModSetup("1185229307")
    ServerModCollectionSetup("1185229307")

    ServerModSetup("1378549454")
    ServerModCollectionSetup("1378549454")
    ```

## 启动、运行、更新服务器
+ 前文已经提及，将所有脚本文件复制到 /home/steam/dst/bin文件夹下，在bin夹下运行不同脚本可以进行不同操作

+ 启动游戏，需要注意启动的存档是哪个，如果是Cluster_1，就需要将start_caves.sh和start_master.sh中的存档参数进行修改成Cluster_1
    ```
    ./start.sh
    ```

+ 关闭游戏
    ```
    ./stop.sh
    ```

+ 更新游戏，更新游戏前最好关闭游戏
    ```
    ./update_starve.sh
    ```

### 参考教程
https://www.bilibili.com/read/cv14002167
https://github.com/cuukenn/dontstarveserver
