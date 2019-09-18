module Dotman::Shell
    class Block
        def initialize(commands)
            @commands = commands
        end

        def to_s(level = 0)
            @commands.map { |command| command.to_s(level) }.join("\n")
        end
    end
end
