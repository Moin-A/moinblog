#!/usr/bin/env ruby



Dir.chdir(File.dirname(__FILE__) + '/..')

# Run bundle install


# # Start the Rails server
# system('bundle exec rails s')

# require 'docker'

# Define the path to your docker-compose.yml file
DOCKER_COMPOSE_PATH = 'docker-compose-db.yml'

# Define the project name for the Docker Compose stack
PROJECT_NAME = 'mysql'

# Define the Docker API version (optional)
system("docker-compose -f #{DOCKER_COMPOSE_PATH} up")

# Load the Docker Compose file

