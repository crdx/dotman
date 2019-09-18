module Dotman::Action
    class Init
        def to_statement
            Shell.statement(init, die)
        end

        private

        def check_host
            Shell.comparison('$HOST', '=', '')
        end

        def check_base
            Shell.comparison('$BASE_DIR', '=', '')
        end

        def init
            Shell.condition([check_host, check_base], :or)
        end

        def die
            Shell.block([
                Shell.echo(:red, 'One or more core environment variables is missing; cannot continue.'),
                Shell.exit(1)
            ])
        end

    end
end
