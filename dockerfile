FROM alpine:latest

RUN apk add --no-cache curl bash tzdata gawk jq
WORKDIR /APP
COPY ./scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]