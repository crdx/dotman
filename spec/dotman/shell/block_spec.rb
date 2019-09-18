describe Dotman::Shell::Block do
    it 'runs a sequence of commands' do
        command1 = Dotman::Shell::Command.new('echo hi')
        command2 = Dotman::Shell::Command.new('echo bye')
        block = described_class.new([command1, command2])
        expect(block.to_s).to eq("echo hi\necho bye")
    end
end
