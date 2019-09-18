module Dotman::Shell
    class Condition
        def initialize(conditions, operator = :and)
            conditions = [conditions] unless conditions.is_a?(Array)
            @operator = operator
            @conditions = conditions.compact
        end

        def to_s
            '( %s )' % @conditions.join(' ' + operator + ' ')
        end

        private

        def operator
            @operator == :and ? '&&' : '||'
        end
    end
end
