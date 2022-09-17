# Dockerfile development version
FROM ruby:3.0.0 AS palenca-development

ARG USER_ID
ARG GROUP_ID

RUN gem uninstall nokogiri

RUN addgroup --gid $GROUP_ID docker
RUN adduser --disabled-password --disabled-login --gecos '' --uid $USER_ID --gid $GROUP_ID docker
RUN newgrp docker

RUN apt-get update && apt-get install glibc-source
ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH
COPY . .
RUN gem install rails bundler

RUN bundle config set force_ruby_platform true
RUN chmod -R 777 /usr/local/bundle/
RUN chown -R docker:docker /usr/local/bundle/
RUN bundle install

RUN chmod -R 777 /opt/app/
RUN chown -R docker:docker /opt/app/

USER $USER_ID

CMD bundle exec unicorn -c config/unicorn.rb
