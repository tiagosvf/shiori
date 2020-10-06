# build stage
FROM golang:alpine AS builder
RUN apk add --no-cache build-base
WORKDIR /src
COPY . .
RUN GOOS=linux GOARCH=arm GOARM=5 go build

# server image
FROM golang:alpine
COPY --from=builder /src/shiori /usr/local/bin/
ENV SHIORI_DIR /srv/shiori/
EXPOSE 8080
CMD ["/usr/local/bin/shiori", "serve"]
