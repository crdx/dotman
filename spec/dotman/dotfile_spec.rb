describe Dotman::Dotfile do
    let (:env) do
        { base: "my_base_dir", "home": "my_home_dir" }
    end

    it 'works' do
        described_class.configure do |config|
            config.link 'source_file', to: 'target_file'
        end

        script = described_class.to_script(env)

        expect(script).to include('ln -s')
        expect(script).to include('source_file')
        expect(script).to include('target_file')
        expect(script).to include('HOME_DIR="my_home_dir"')
        expect(script).to include('BASE_DIR="my_base_dir"')
    end
end
