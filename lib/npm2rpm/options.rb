#
# npm2rpm/lib/options.rb
#
# Extract ARGV options
#

require 'getoptlong'

module Npm2Rpm
  class Options
    attr_reader :package, :version, :date, :email, :user

    def initialize
      # .changes format
      @date = `date -u +'%a %b %d %T UTC %Y'`
      @date.chomp!

      @email = ENV["USER"]
      @user = `getent passwd $email`.split(':')[4]
      @package = nil

      # Parse command line options
      GetoptLong.new(
        [ '-h', '--help', GetoptLong::NO_ARGUMENT ],
        [ '-H', '--man', GetoptLong::NO_ARGUMENT ],
        [ '--specdir', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--sourcedir', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--user', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--email', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--date', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--package', GetoptLong::REQUIRED_ARGUMENT ]
      ).each do |opt, arg|
        case opt
        when '--specdir'
          @specdir = arg
        when '--sourcedir'
          @sourcedir = arg
        when '--user'
          @user = arg
        when '--email'
          @email = arg
        when '--date'
          @date = arg
        when '--package'
          self.package = arg
        else
          "Run $0 -h or $0 -H for details on usage";
        end
      end
      unless ARGV.empty?
        if @package
          abort "Extra arguments: #{ARGV}"
        end
        self.package = ARGV.shift
      end

      abort 'Missing package argument' unless @package;
      abort "Extra arguments: #{ARGV}" unless ARGV.empty?;

    end
  
    def package= name
      @package, @version = name.split "@"
    end
  end

end
