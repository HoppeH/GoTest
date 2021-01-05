FROM golang:1.15.6 as base

WORKDIR /go
ENV GOPATH=/go
COPY . .

FROM base as dev
RUN ["go", "get", "github.com/githubnemo/CompileDaemon"]

# RUN CompileDaemon -build="go build ./cmd/main.go" -command="./main" -polling=true
ENTRYPOINT CompileDaemon -build="go build ./cmd/main.go" -command="./main"

FROM base as builder
RUN CGO_ENABLED=0 GOOS=linux go build /go/cmd/main.go



# generate clean, final image for end users
FROM alpine:3.12.3 as prod
WORKDIR /go/server/
COPY --from=builder /go /go/server

# executable
ENTRYPOINT [ "./main" ]

