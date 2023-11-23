FROM golang:1.20 AS builder
WORKDIR /src
COPY . .
RUN go mod download
RUN go build -o /app && ls -l /

FROM alpine AS runtime
COPY --from=builder /app /app
CMD ["/app"]