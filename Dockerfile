FROM aptible/ruby:1.9.3-ubuntu-12.04
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libxslt-dev libxml2-dev
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
EXPOSE 3000