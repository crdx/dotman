describe Dotman::Shell::Comparison do
    it 'handles unary operators' do
        comparison = described_class.new('a', '=', 'b')
        expect(comparison.to_s).to eq('[ "a" = "b" ]')
    end

    it 'handles binary operators' do
        comparison = described_class.new('a', '-l')
        expect(comparison.to_s).to eq('[ -l "a" ]')
    end
end
