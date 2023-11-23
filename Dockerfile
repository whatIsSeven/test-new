FROM golang:1.20-alpine3.18 AS builder
WORKDIR /src
COPY . .
RUN go mod tidy
RUN go build -o /app

FROM alpine:3.18 AS runtime
COPY --from=builder /app /app
CMD ["/app"]