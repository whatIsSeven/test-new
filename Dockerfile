FROM golang:1.20 AS builder
WORKDIR /src
COPY . .
RUN go mod tidy
RUN go build -o /app

FROM alpine AS runtime
COPY --from=builder /app /app
CMD ["/app"]