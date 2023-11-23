FROM golang:1.20 AS builder
WORKDIR /src
COPY . .
RUN go mod download
RUN go build -o /app && ls -l /
CMD ["/app"]
