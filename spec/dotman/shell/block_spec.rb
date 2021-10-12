describe Dotman::Shell::Block do
    it 'runs a sequence of commands' do
        command_1 = Dotman::Shell::Command.new('echo hi')
        command_2 = Dotman::Shell::Command.new('echo bye')
        block = described_class.new([command_1, command_2])
        expect(block.to_s).to eq("echo hi\necho bye")
    end
end
