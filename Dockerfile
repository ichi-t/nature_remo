LABEL mainteiner="taisuke_ichimura@icloud.com"

FROM ruby:2.5.1

WORKDIR /app
COPY ./ /app/

RUN gem update --system && \
    gem install bundler -v 2.0.2 && \
    bundle _2.0.2_ install && \
    bundle _2.0.2_ exec rake install:local

ENTRYPOINT ["natureremo"]
