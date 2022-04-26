FROM ubuntu:impish AS build
WORKDIR /build
RUN apt update && apt install -y make golang-go ca-certificates
COPY . .
ENV CGO_ENABLED=0
ENV GOOS=linux
RUN make install
RUN go install cloud.google.com/go/cbt@latest

FROM ubuntu:impish AS run
COPY --from=build /usr/local/bin/little_bigtable /usr/local/bin/little_bigtable
COPY --from=build /root/go/bin/cbt /usr/local/bin/cbt
CMD ["/usr/local/bin/little_bigtable"]
