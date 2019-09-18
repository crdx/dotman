describe Dotman::DotfileConfiguration do
    before(:each) do
        @config = described_class.new
    end

    let (:env) do
        { base: "my_base_dir", "home": "my_home_dir" }
    end

    it 'symlinks' do
        @config.link 'rc', to: '.rc'
        expect(@config.to_script(env)).to include('ln -s')
    end

    it 'symlink includes a specific host' do
        @config.link 'rc', to: '.rc', only: [:host]
        expect(@config.to_script(env)).to include('ln -s')
        expect(@config.to_script(env)).to include('host')
        expect(@config.to_script(env)).to include('=')
    end

    it 'symlink includes specific hosts' do
        @config.link 'rc', to: '.rc', only: [:host1, :host2]
        expect(@config.to_script(env)).to include('ln -s')
        expect(@config.to_script(env)).to include('host1')
        expect(@config.to_script(env)).to include('host2')
        expect(@config.to_script(env)).to include('=')
    end

    it 'symlink excludes a specific host' do
        @config.link 'rc', to: '.rc', except: [:host]
        expect(@config.to_script(env)).to include('ln -s')
        expect(@config.to_script(env)).to include('host')
        expect(@config.to_script(env)).to include('!=')
    end

    it 'symlink excludes specific hosts' do
        @config.link 'rc', to: '.rc', except: [:host1, :host2]
        expect(@config.to_script(env)).to include('ln -s')
        expect(@config.to_script(env)).to include('host1')
        expect(@config.to_script(env)).to include('host2')
        expect(@config.to_script(env)).to include('!=')
    end

    it 'sets HOST and BASE in the header' do
        expect(@config.to_script(env)).to include('HOST=')
        expect(@config.to_script(env)).to include('BASE_DIR="my_base_dir"')
    end

    it 'aliases hosts correctly' do
        @config.alias_host :host1, :host2
        @config.link 'rc', to: '.rc', except: [:host1]
        expect(@config.to_script(env)).to include('host2')
    end
end
