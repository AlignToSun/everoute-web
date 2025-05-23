FROM golang:1.18 AS builder
WORKDIR /app
COPY . .

# Set GO111MODULE to auto
RUN go env -w GO111MODULE=auto

# Install dependencies
RUN go get github.com/gorilla/rpc \
    && go get github.com/dertseha/everoute/universe \
    && go get github.com/redteadev/everoute-web/data

# Build the application
RUN go build -o everoute-web

FROM gcr.io/distroless/base
COPY --from=builder /app/everoute-web /everoute-web
EXPOSE 3000
CMD ["/everoute-web"]