FROM --platform=linux/amd64 golang:1.19 AS builder-amd64
WORKDIR /src
COPY . .
RUN go mod tidy
RUN GOOS=linux GOARCH=amd64 go build -o /app

# 阶段 2：为 amd64 创建镜像
FROM --platform=linux/amd64 alpine AS runtime-amd64
COPY --from=builder-amd64 /app /app
CMD ["/app"]

# 阶段 3：为 arm64 构建应用
FROM --platform=linux/arm64 golang:1.19 AS builder-arm64
WORKDIR /src
COPY . .
RUN go mod tidy
RUN GOOS=linux GOARCH=arm64 go build -o /app

# 阶段 4：为 arm64 创建镜像
FROM --platform=linux/arm64 alpine AS runtime-arm64
COPY --from=builder-arm64 /app /app
CMD ["/app"]