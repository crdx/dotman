module Dotman::Shell
    class Comparison
        def initialize(operand1, operator, operand2 = nil)
            @operand1, @operator, @operand2 = operand1, operator, operand2
        end

        def to_s
            if @operand2.nil?
                '[ %s "%s" ]' % [@operator, @operand1]
            else
                '[ "%s" %s "%s" ]' % [ @operand1, @operator, @operand2 ]
            end
        end
    end
end
