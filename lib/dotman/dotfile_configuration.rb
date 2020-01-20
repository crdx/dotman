module Dotman
    class DotfileConfiguration
        def initialize
            @actions, @host_aliases = [], {}
        end

        def link(from, to: nil, **args)
            add_action Action::Link.new(from, to), args
        end

        def to_script(env)
            [header(env), actions, footer].join
        end

        def alias_host(from, to)
            @host_aliases[from] = to
        end

        private

        def add_action(action, args)
            @actions << Shell::Statement.new(satisfies_args(args), action.to_statement)
        end

        def satisfies_args(args)
            Shell.satisfies_args(@host_aliases, **args)
        end

        def actions
            actions_list.map(&:to_s).join("\n\n").strip
        end

        def actions_list
            [Action::Init.new.to_statement, *@actions]
        end

        def header(env)
            return <<~EOF
                #!/bin/bash
                set -e

                HOST="$(hostname -s)"
                BASE_DIR="#{env[:base]}"
                HOME_DIR="#{env[:home]}"

                echo HOST="#{'$HOST'.bold}"
                echo BASE_DIR="#{'$BASE_DIR'.bold}"
                echo HOME_DIR="#{'$HOME_DIR'.bold}"

                echo "#{['Starting...'].shelljoin.green}"

            EOF
        end

        def footer
            "\n\n" + 'echo "%s"' % 'Finished.'.green
        end
    end
end
