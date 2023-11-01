#!/usr/bin/env ruby


# Set environment variables
ENV['ALLOWED_ORIGIN'] = 'http://localhost:3006'
ENV['BACKEND_URL'] = 'http://localhost:3000'
ENV['BACKEND_HOST_NAME'] = 'localhost'
ENV['google_client_secret'] = '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'
ENV['google_client_id'] = '946502148013-u6hgpl13f8hum1cc6ubamh6d3htvhiev.apps.googleusercontent.com'
ENV['jwt_secret_key'] = 'a6b3c5f5232304609cc28f8ef5b7de6ccb891ab2acc5450c303dac30ab9702a1d9a4f3130a70ee67afa8f6ea1e28219a91ef31fb8605d33260c7cf50bb0d3520'

# Change directory to the project root
Dir.chdir(File.dirname(__FILE__) + '/..')

# Run bundle install
# system('bundle install --path=.bundle')

# system('bundle exec rails db:setup')

# sleep(2)

# system('bundle exec rails db:migrate')
system("rails generate channel Appearance")
# # Start the Rails server
system('rails s')

# require 'docker'



