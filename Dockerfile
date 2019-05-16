FROM fluent/fluentd:v1.3-1

# Use root account to use apk
USER root

RUN apk add --no-cache --update --virtual .build-deps \
	build-base ruby-dev

RUN gem install fluent-plugin-s3 -v 1.1.8 \
	&& gem sources --clear-all \
	&& apk del .build-deps \
	&& rm -rf /home/fluent/.gem/ruby/2.5.0/cache/*.gem

COPY fluent.conf /fluentd/etc/

USER fluent