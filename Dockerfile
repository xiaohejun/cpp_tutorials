# 基础镜像
FROM ubuntu:20.04

LABEL key="1.0"
LABEL maintainer="junhe0618@gmail.com"


# 下面命令正确地设置了时区为亚洲/上海（Asia/Shanghai）。这将确保容器在中国的时区中运行，并且在构建过程中不会有交互式提示。
# 以下是命令的说明：
# ENV DEBIAN_FRONTEND=noninteractive: 这个命令设置环境变量 DEBIAN_FRONTEND 的值为 noninteractive，以避免在包管理操作期间出现交互式提示。
# ENV TZ=Asia/Shanghai: 这个命令设置环境变量 TZ 的值为 Asia/Shanghai，即将时区设置为中国的上海时区。
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone: 这个命令在容器中运行，并执行两个操作：
# ln -snf /usr/share/zoneinfo/$TZ /etc/localtime: 它将 /usr/share/zoneinfo/$TZ 软链接到容器内的 /etc/localtime，以将时区设置为指定的时区。
# echo $TZ > /etc/timezone: 它将指定的时区值写入 /etc/timezone 文件，以持久化保存时区设置。
# 这样，当您构建和运行 Docker 镜像时，容器将使用亚洲/上海时区进行操作。
ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 更新
RUN apt-get update

# 该命令用于在一个 Docker 容器中安装多个软件包，以支持软件开发和调试的常见需求。让我逐个解释这些软件包的作用：
# build-essential: 提供构建软件所需的基本工具和库，包括编译器、构建工具和标准 C 库等。
# cmake: 一个跨平台的构建工具，用于管理和构建 C/C++ 项目。
# git: 版本控制系统，用于跟踪和管理代码的变更。
# openssh-server: SSH 服务器，用于远程登录和文件传输。
# gdb: GNU 调试器，用于调试程序。
# pkg-config: 用于获取编译和链接软件包所需的元数据信息。
# valgrind: 用于内存调试、性能分析和程序错误检测的工具。
# systemd-coredump: 用于管理系统崩溃时生成的核心转储文件。
# -y表示当系统要求我们安装软件包时接受 "是"。
RUN apt-get install -y build-essential cmake git openssh-server gdb pkg-config valgrind systemd-coredump