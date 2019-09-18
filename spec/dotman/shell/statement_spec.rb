describe Dotman::Shell::Statement do
    it 'handles a logical statement' do
        b, c = double, double
        expect(b).to receive(:to_s).with(1).and_return('b')
        expect(c).to receive(:to_s).with(1).and_return('c')
        statement = described_class.new('a', b, c)
        expect(statement.to_s).to eq("if a; then\nb\nelse\nc\nfi")
    end
end
