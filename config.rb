# frozen_string_literal: true

require 'figaro'

Figaro.application = Figaro::Application.new(
  environment: :development,
  path: File.expand_path('config/secrets.yml')
)

Figaro.load
def self.config = Figaro.env

# require 'econfig'
# extend Econfig::Shortcut
# Econfig.env = 'development'
# Econfig.root = File.expand_path('.')
