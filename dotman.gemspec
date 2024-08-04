require_relative 'lib/dotman/version'

Gem::Specification.new do |spec|
    spec.homepage = 'https://github.com/crdx/dotman'
    spec.summary = 'Manage dotfiles'
    spec.name = 'dotman-bin'
    spec.version = Dotman::VERSION
    spec.author = 'crdx'
    spec.license = 'GPLv3'
    spec.metadata['rubygems_mfa_required'] = 'true'

    spec.required_ruby_version = '>= 3.0'

    spec.files = Dir['lib/**/*']
    spec.executables = ['dotman']

    spec.add_dependency 'colorize', '~> 0.8.1'
    spec.add_dependency 'docopt', '~> 0.6.1'
    spec.add_dependency 'json', '~> 2.7'
    spec.add_dependency 'require_all', '~> 3.0'

    spec.add_development_dependency 'rake', '~> 13.0'
    spec.add_development_dependency 'rspec', '~> 3.8'
    spec.add_development_dependency 'simplecov', '~> 0.21.0'
end
