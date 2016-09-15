#
# npm2rpm/lib/options.rb
#
# Extract ARGV options
#

require 'getoptlong'

module Npm2Rpm
  class Options
    attr_reader :package, :version, :date, :email, :user, :debug
    
    def usage msg=nil
      STDERR.puts msg if msg
      STDERR.puts "Usage:"
      STDERR.puts "npm2rpm [<options>] <module>"
      STDERR.puts "<options>:"
      STDERR.puts "\t-h, --help: this help"
      STDERR.puts "\t--specdir <dir> -- where to find .spec"
      STDERR.puts "\t--sourcedir <dir> -- where to find src"
      STDERR.puts "\t--user <user>"
      STDERR.puts "\t--email <email>"
      STDERR.puts "\t--data <date>"
      STDERR.puts "\t--package <package>"
      exit (msg ? 1 : 0)
    end

    def initialize
      # .changes format
      @date = `date -u +'%a %b %d %T UTC %Y'`
      @date.chomp!

      @email = ENV["USER"]
      @user = `getent passwd $email`.split(':')[4]
      @package = nil
      @debug = nil

      # Parse command line options
      GetoptLong.new(
        [ '-h', '--help', GetoptLong::NO_ARGUMENT ],
        [ '-H', '--man', GetoptLong::NO_ARGUMENT ],
        [ '-d', '--debug', GetoptLong::NO_ARGUMENT ],
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
        when '--debug'
          @debug = true
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

      abort "Extra arguments: #{ARGV}" unless ARGV.empty?;

    end
  
    def package= name
      @package, @version = name.split "@"
      case @version.split(".").size
      when 1
        @version << ".0.0"
      when 2
        @version << ".0"
      when 3
        # ok
      else
        raise "Not a semantic version #{@version.inspect}"  
      end if @version
    end
  end

end
