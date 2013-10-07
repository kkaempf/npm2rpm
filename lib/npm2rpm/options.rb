require 'getoptlong'

class Options
  attr_reader :package, :version, :date, :email, :user

  def initialize

    # .changes format
    @date = `date -u +'%a %b %d %T UTC %Y'`
    @date.chomp!

    @email = ENV["USER"]
    @user = `getent passwd $email`.split(':')[4]
    @package = nil

    options = Options.new
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
        options.specdir = arg
      when '--sourcedir'
        options.sourcedir = arg
      when '--user'
        options.user = arg
      when '--email'
        options.email = arg
      when '--date'
        options.date = arg
      when '--package'
        options.package = arg
      else
        "Run $0 -h or $0 -H for details on usage";
      end
    end

    unless ARGV.empty?
      if options.package
        abort "Extra arguments: #{ARGV}"
      end
      options.package = ARGV.shift
    end

    abort 'Missing package argument' unless options.package;
    abort "Extra arguments: #{ARGV}" unless ARGV.empty?;

  end
  
  def package= name
    @package, @version = name.split "@"
  end
end

