module Dotman::Shell
    class Command
        def initialize(str)
            @str = str
        end

        def to_s(level = 0)
            (' ' * (level * 4)) + @str
        end
    end
end
