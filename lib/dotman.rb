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

require_relative 'dotman/version'
require_relative 'dotman/dotfile'
require_relative 'dotman/dotfile_configuration'
require_relative 'dotman/shell'

require_relative 'dotman/actions/init'
require_relative 'dotman/actions/link'

require_relative 'dotman/checks/host'

require_relative 'dotman/shell/block'
require_relative 'dotman/shell/command'
require_relative 'dotman/shell/comparison'
require_relative 'dotman/shell/condition'
require_relative 'dotman/shell/statement'
