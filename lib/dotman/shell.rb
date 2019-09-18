module Dotman
    module Shell
        def self.satisfies_args(aliases, only: [], except: [])
            if only.length > 0
                Check::Host.new(aliases, only, include: true).to_comparison
            elsif except.length > 0
                Check::Host.new(aliases, except, include: false).to_comparison
            end
        end

        def self.echo(colour, msg)
            command('echo "%s"' % msg.send(colour))
        end

        def self.exit(code)
            command('exit ' + code.to_s)
        end

        def self.indent(level)
            ' ' * (level * 4)
        end

        def self.block(*args)
            Block.new(*args)
        end

        def self.command(*args)
            Command.new(*args)
        end

        def self.comparison(*args)
            Comparison.new(*args)
        end

        def self.condition(*args)
            Condition.new(*args)
        end

        def self.statement(*args)
            Statement.new(*args)
        end
    end
end
