FROM alpine

# 设置工作目录
WORKDIR /app

# 把你的可执行文件添加到 Docker 镜像中
COPY ./test /app/test

# 设置当 Docker 镜像启动时运行的命令
CMD ["/app/test"]