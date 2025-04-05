module Dotman::Action
    class Link
        def initialize(from, to)
            @from = from
            @to = to
        end

        def to_statement
            Shell.statement(does_not_exist, create_link, check_link)
        end

        private

        attr_reader :from
        attr_reader :to

        def pair
            [from, to]
        end

        def check_link
            Shell.statement(link_is_set_up, link_set_up, link_not_set_up)
        end

        def does_not_exist # rubocop:disable Naming/PredicateName
            Shell.comparison('$HOME_DIR/' + to, '! -e')
        end

        def create_link
            block = [
                Shell.command('ln -s "$BASE_DIR/%s" "$HOME_DIR/%s"' % pair),
                Shell.echo(:yellow, 'Link $BASE_DIR/%s → $HOME_DIR/%s created' % pair),
            ]

            dirname = File.dirname(pair[1])
            if dirname != '.'
                block.prepend(Shell.command('mkdir --parents $HOME_DIR/%s' % dirname))
            end

            Shell.block(block)
        end

        def link_is_set_up
            Shell.comparison('$(realpath $HOME_DIR/%s)' % to, '=', '$BASE_DIR/' + from)
        end

        def link_set_up
            Shell.echo(:green, 'Link $BASE_DIR/%s → $HOME_DIR/%s looking good' % pair)
        end

        def link_not_set_up
            Shell.echo(:red, 'Link $BASE_DIR/%s → $HOME_DIR/%s is not set up' % pair)
        end
    end
end
