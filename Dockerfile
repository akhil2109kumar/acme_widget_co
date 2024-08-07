FROM ruby:3.2.2

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /acme_widget_co

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

# The command to run the RSpec tests
# CMD ["bundle", "exec", "rspec"]
# CMD ["ruby", "run_basket.rb"]