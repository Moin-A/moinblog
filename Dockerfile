# Use the official Ruby 3.0 image as the base image
FROM ruby:3.1.2

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    nodejs \
    yarn

# Set the working directory to /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install gems with bundler
RUN gem install bundler -v '~> 2.2' && bundle install --path=.bundle

# Copy the rest of the application code to the container
COPY . .

# Precompile assets
RUN rails assets:precompile

# Set the command to start the Rails server
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]

