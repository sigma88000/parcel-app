FROM golang:1.25.5 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o app .

FROM debian:stable-slim

WORKDIR /app

COPY --from=builder /app/app .
COPY --from=builder /app/tracker.db .

CMD ["./app"]