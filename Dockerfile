FROM ruby:3.3.5

RUN apt-get update -qq && apt-get install -y nodejs

RUN git config --global user.name "abi76416949"
RUN git config --global user.email "abigail.durand@unas.edu.pe"

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN gem install rails -v 7.0
RUN bundle install
RUN gem install pg
COPY . .
EXPOSE 3000

