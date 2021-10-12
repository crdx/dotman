require 'require_all'
require 'colorize'
require 'docopt'

require 'shellwords'
require 'ostruct'
require 'socket'

module Dotman
    def self.root_dir
        File.expand_path('..', __dir__)
    end
end

require_rel 'dotman'
