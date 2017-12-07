require 'econfig'
extend Econfig::Shortcut
Econfig.env = 'development'
Econfig.root = File.expand_path('.')