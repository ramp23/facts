FROM golang:latest AS builder
WORKDIR /go/src/app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest
ENV PORT=8080
COPY --from=builder /go/src/app/main /app/
WORKDIR /app
CMD ["./main"]