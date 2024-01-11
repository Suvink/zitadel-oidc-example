FROM golang:1.21

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /zitadel-oidc-example

EXPOSE 3000

ENV CLIENT_ID="myclient"
ENV CLIENT_SECRET="verysecret"

# Create a new user with UID 10014
RUN useradd -u 10031 test
# Set a non-root user
USER 10031

CMD ["/zitadel-oidc-example"]
