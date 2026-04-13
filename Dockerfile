FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY api-go/go.mod .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main ./api-go

FROM alpine:3.23

RUN apk --no-cache add ca-certificates=20251003-r0

WORKDIR /root/

COPY --from=builder /app/main .

EXPOSE 3000

CMD ["./main"]
