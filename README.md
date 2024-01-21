# cpp_tutorials
这个仓库是我学习cpp的地方

使用docker构建环境
使用vscode作为IDE

为什么用docker:
1. docker可以将开发环境隔离
2. 如果你的电脑是mac或者windows但是想有一个lunix的开发环境

TODO:后面可能也会尝试clion+docker

## 环境运行

### 前置条件
安装docker
https://www.docker.com/get-started/

安装vscode
https://code.visualstudio.com/

### 下载本仓库
```shell
git clone git@github.com:xiaohejun/cpp_tutorials.git
```

### 构建docker镜像

```shell
docker build -t cpp_tutorials .
```
初次构建等待时间可能比较长，因为需要下载镜像和安装

```shell
❯ docker build -t cpp_tutorials .
[+] Building 587.8s (8/8) FINISHED
 => [internal] load build definition from Dockerfile                                                                         0.0s
 => => transferring dockerfile: 2.28kB                                                                                       0.0s
 => [internal] load .dockerignore                                                                                            0.0s
 => => transferring context: 2B                                                                                              0.0s
 => [internal] load metadata for docker.io/library/ubuntu:20.04                                                              4.7s
 => CACHED [1/4] FROM docker.io/library/ubuntu:20.04@sha256:f2034e7195f61334e6caff6ecf2e965f92d11e888309065da85ff50c617732b  0.0s
 => [2/4] RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone                 0.2s
 => [3/4] RUN apt-get update                                                                                                54.2s
 => [4/4] RUN apt-get install -y build-essential cmake git openssh-server gdb pkg-config valgrind systemd-coredump         527.3s
 => exporting to image                                                                                                       1.4s
 => => exporting layers                                                                                                      1.4s
 => => writing image sha256:a5ee9b90481ab9d97203e08c7dae462cc4f6c026a3e48a3ee973140cb61c1632                                 0.0s
 => => naming to docker.io/library/cpp_tutorials                                                                             0.0s

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
```
解释该命令的各个部分：

docker build: 这是 Docker 命令的一部分，用于构建 Docker 镜像。
- -t cpp_tutorials:
-t 参数用于指定构建的镜像的标签（tag）。在这个例子中，镜像的标签被设置为 cpp_tutorials，您可以根据需要自行更改。

- .: 
这表示 Dockerfile 的路径，. 表示当前目录。Dockerfile 是一个包含构建指令的文本文件，它定义了如何构建 Docker 镜像。

使用这个命令，您可以在当前目录中的 Dockerfile 中定义的环境中构建一个名为 cpp_tutorials 的 Docker 镜像。Docker 将按照 Dockerfile 中指定的指令执行构建过程，并生成一个可用的镜像。

请确保在运行该命令之前，您已经在当前目录中创建了正确的 Dockerfile，并且 Docker 已经正确安装和配置在您的系统上。

构建完成后，您可以使用 docker images 命令来查看已经构建的镜像列表，其中应该包含您新构建的 cpp_tutorials 镜像。

### 确认镜像构建成功
```shell
docker images
```
可以看到成功构建了cpp_tutorials镜像
```shell
❯ docker images
REPOSITORY      TAG       IMAGE ID       CREATED         SIZE
cpp_tutorials   latest    a5ee9b90481a   2 minutes ago   583MB
```

### 在容器中运行镜像
```shell
docker run --name cpp_tutorials_container -v /Users/hejun/project/cpp_tutorials:/cpp_tutorials -it cpp_tutorials
```
该命令的各个部分的解释如下：

- docker run: 这是 Docker 命令的一部分，用于在容器中运行镜像。
- --name cpp_tutorials_container: --name 参数用于指定容器的名称。在这个例子中，容器的名称被设置为 cpp_tutorials_container，您可以根据需要自行更改。
- -v /Users/hejun/project/cpp_tutorials:/cpp_tutorials: -v 参数用于将主机的目录（/Users/hejun/project/cpp_tutorials）与容器内部的目录（/cpp_tutorials）进行挂载（映射）。这样可以在容器内访问主机上的文件和目录。
- -it: -i 和 -t 参数一起使用，以交互模式运行容器，并分配一个终端（TTY）以便与容器进行交互。
- cpp_tutorials: 这是要运行的镜像的名称。
使用这个命令，您可以在一个新的容器中运行名为 cpp_tutorials 的镜像。容器将会创建，并在交互模式下启动，您可以在容器的终端中执行命令和操作。

在容器中，您通过 -v 参数将主机上的 /Users/hejun/project/cpp_tutorials 目录挂载到容器内的 /cpp_tutorials 目录。这使得容器内的操作可以访问主机上的文件和目录，方便在开发环境中共享和处理代码。

### 查看容器
```shell
❯ docker ps
CONTAINER ID   IMAGE           COMMAND       CREATED              STATUS              PORTS     NAMES
4dae16c6c153   cpp_tutorials   "/bin/bash"   About a minute ago   Up About a minute             cpp_tutorials_container

```

### 进入正在运行的容器
```shell
docker start -i cpp_tutorials_container
```
