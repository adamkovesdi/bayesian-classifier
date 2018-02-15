FROM ruby:latest 
MAINTAINER adamkov

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

ENV LC_ALL C.UTF-8
ENV app /app
RUN mkdir $app
WORKDIR $app 
ADD . $app 

CMD ["ruby", "/app/interface.rb"]
