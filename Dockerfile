FROM ubuntu:impish AS build
WORKDIR /build
RUN apt update && apt install -y make golang-go
COPY . .
ENV CGO_ENABLED=0
ENV GOOS=linux
RUN make install

FROM ubuntu:impish AS run
COPY --from=build /usr/local/bin/little_bigtable /usr/local/bin/little_bigtable
CMD ["/usr/local/bin/little_bigtable"]
