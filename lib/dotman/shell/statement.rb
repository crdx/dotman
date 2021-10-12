module Dotman::Shell
    class Statement
        def initialize(condition, true_statement, false_statement = nil)
            @condition = condition
            @true_statement = true_statement
            @false_statement = false_statement
        end

        def to_s(level = 0)
            if @condition.nil?
                return @true_statement.to_s(level)
            end

            indent = Shell.indent(level)

            s = indent + "if %s; then\n" % @condition
            s << "%s\n" % @true_statement.to_s(level + 1)

            if @false_statement
                s << indent + "else\n"
                s << "%s\n" % @false_statement.to_s(level + 1)
            end

            s << indent + 'fi'
            s
        end
    end
end
