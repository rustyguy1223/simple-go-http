FROM golang:1.22.3-alpine AS builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o http-server .

FROM alpine:latest  

WORKDIR /app

COPY --from=builder /app/http-server .

EXPOSE 8080

CMD ["./http-server"]
