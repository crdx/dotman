module Dotman
    class Dotfile
        def self.configure
            config = DotfileConfiguration.new
            @@config = config
            yield config
        end

        def self.to_script(env)
            @@config.to_script(env)
        end
    end
end
