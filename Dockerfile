FROM --platform=linux/amd64 golang AS builder-amd64
# 阶段 1：为 amd64 构建应用
WORKDIR /src
COPY . .
RUN cd test & GOOS=linux GOARCH=amd64 go build -x -o app-amd64 ./test

# 阶段 2：为 arm64 构建应用
FROM --platform=linux/arm64 golang AS builder-arm64
WORKDIR /src
COPY . .
RUN cd test GOOS=linux GOARCH=arm64 go build -x -o app-arm64 ./test

# 阶段 3：为 amd64 创建运行时镜像
FROM --platform=linux/amd64 alpine AS runtime-amd64
WORKDIR /app
COPY --from=builder-amd64 /src/app-amd64 ./app
CMD ["/app/app"]

# 阶段 4：为 arm64 创建运行时镜像
FROM --platform=linux/arm64 alpine AS runtime-arm64
WORKDIR /app
COPY --from=builder-arm64 /src/app-arm64 ./app
CMD ["/app/app"]