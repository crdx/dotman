describe Dotman::Shell::Command do
    it 'runs a command' do
        str = 'echo hi'
        command = described_class.new(str)
        expect(command.to_s).to eq(str)
    end
end
