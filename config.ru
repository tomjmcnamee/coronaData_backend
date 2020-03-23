# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
config.logger = Logger.new(STDOUT)

run Rails.application
