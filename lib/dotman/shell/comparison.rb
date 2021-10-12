module Dotman::Shell
    class Comparison
        def initialize(operand_1, operator, operand_2 = nil)
            @operand_1 = operand_1
            @operator = operator
            @operand_2 = operand_2
        end

        def to_s
            if @operand_2.nil?
                '[ %s "%s" ]' % [@operator, @operand_1]
            else
                '[ "%s" %s "%s" ]' % [@operand_1, @operator, @operand_2]
            end
        end
    end
end
