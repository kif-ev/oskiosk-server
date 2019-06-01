FROM ruby:2.4.6-alpine

# Install system dependencies
RUN apk --no-cache add postgresql-dev build-base linux-headers libffi libffi-dev zlib zlib-dev tzdata yarn

# Copy the code and create unprivileged user
WORKDIR /app
COPY . .
RUN adduser -D oskiosk && chown -R oskiosk:oskiosk /app
USER oskiosk

# Install application dependencies
RUN gem install bundler && bundle install --without test development && yarn install

# Add database config
RUN cp docker/database.yml config/database.yml

# Start script
EXPOSE 8000
CMD sleep 10 && bundle exec rake db:migrate && bundle exec rake assets:precompile && bundle exec unicorn -p 8000 -c ./config/unicorn.rb