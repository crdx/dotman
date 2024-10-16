module Dotman::Check
    class Host
        def initialize(aliases, hosts, include: true)
            @aliases = aliases
            @hosts = hosts
            @include = include
        end

        def to_comparison
            Shell.condition(hosts.map { compare(_1) }, condition_operator)
        end

        private

        def condition_operator
            @include ? :or : :and
        end

        def comparison_operator
            @include ? '=' : '!='
        end

        def compare(host)
            Shell.comparison('$HOST', comparison_operator, host)
        end

        def hosts
            @hosts.map { get_alias(_1) }
        end

        def get_alias(target)
            @aliases[target] || target
        end
    end
end
