FROM ruby:3.1.2
LABEL mainteiner="taisuke_ichimura@icloud.com"

WORKDIR /app
COPY ./ /app/

RUN gem update --system && \
    gem install bundler -v 2.3.14 && \
    bundle _2.3.14_ install && \
    bundle _2.3.14_ exec rake install:local

ENTRYPOINT ["natureremo"]
