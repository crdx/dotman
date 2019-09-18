describe Dotman::Check::Host do
    it 'includes multiple hosts correctly' do
        check = described_class.new({}, [:host1, :host2], include: true)
        expect(check.to_comparison.to_s).to include('[ "$HOST" = "host1" ] || [ "$HOST" = "host2" ]')
    end

    it 'excludes multiple hosts correctly' do
        check = described_class.new({}, [:host1, :host2], include: false)
        expect(check.to_comparison.to_s).to include('[ "$HOST" != "host1" ] && [ "$HOST" != "host2" ]')
    end
end
