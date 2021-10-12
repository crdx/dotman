describe Dotman::Shell::Condition do
    it 'joins conjunctions correctly' do
        condition = described_class.new(%w[tomato potato], :and)
        expect(condition.to_s).to eq('( tomato && potato )')
    end

    it 'joins disjunctions correctly' do
        condition = described_class.new(%w[tomato potato], :or)
        expect(condition.to_s).to eq('( tomato || potato )')
    end
end
