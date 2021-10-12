describe Dotman::Check::Host do
    it 'includes multiple hosts correctly' do
        check = described_class.new({}, %i[host_1 host_2], include: true)
        expect(check.to_comparison.to_s).to include('[ "$HOST" = "host_1" ] || [ "$HOST" = "host_2" ]')
    end

    it 'excludes multiple hosts correctly' do
        check = described_class.new({}, %i[host_1 host_2], include: false)
        expect(check.to_comparison.to_s).to include('[ "$HOST" != "host_1" ] && [ "$HOST" != "host_2" ]')
    end
end
