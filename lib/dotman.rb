Dir.chdir __dir__ do
    require 'bundler/setup'
    require 'require_all'
    require 'colorize'
    require 'docopt'

    require 'shellwords'
    require 'ostruct'
    require 'socket'
end

module Dotman; end
require_rel 'dotman'
