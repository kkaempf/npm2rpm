#
# lib/npm2rpm/spec.rb
#
# Container for .spec related information
#

module Npm2Rpm
  class Spec
    attr_reader :name
    private
    # Convert Hash of npmjs dependencies to Array of RPM requires
    # input:
    #   { "grunt-contrib-nodeunit": "~0.1.0", "grunt-contrib-internal": "~0.1.0", "grunt": "~0.4.0" }
    # output
    #   [ "npm(grunt-contrib-nodeunit@0.1.0", npm(grunt-contrib-internal@0.1.0), "npm(grunt@0.4.0) }
    def dependencies deps
      result = Array.new
      deps ||= Hash.new
      deps.each do |name, version|
        case version
        # "~1.2.3"
        when /^~?([\d\.]+)$/
          result << "npm(#{name}@#{$1})"
        # "1.2.0-1.2.3"
        when /^([\d\.]+)-([\d\.]+)$/
          result << "npm(#{name}@#{$2})"
        # "1.2.x"
        when /^([\d\.]+)\.x$/
          loop do
            v = $1
            next if v =~ /([\d\.]+)\.x/
            result << "npm(#{name}) > #{v}"
            break
          end
        # ">= 1.0.0 < 1.2.0"
        when /^\>=?\s*([\d\.]+)(\s+\<\s*([\d\.]+))?$/
          result << "npm(#{name}) >= #{$1}"
          result << "npm(#{name}) < #{$3}" if $2
        # "*"
        # ""
        when "*", ""
          result << "npm(#{name})"
        else
          raise "Unrecognized dependency #{name.inspect}: #{version.inspect}"
        end
      end
      result
    end
    public
    def initialize metadata
      @metadata = metadata
      @name = "nodejs-#{@metadata.name}_#{@metadata.version}"
    end

    def npmname
      @metadata.name
    end
    def version
      @metadata.version
    end
    def licenses
      [ @metadata.license ]
    end
    def summary
      @metadata.summary
    end
    def description
      @metadata.description
    end
    def homepage
      @metadata.npmdata["homepage"] || @metadata.tarball || abort('FIXME: No homepage found')
    end
    
    def source
      @metadata.tarball
    end
    def dir
      # Find out the top-level directory from tarball
      # The upstreams often use very weird ones
      [`tar tzf #{@local_source}` =~ /([^\/]+)/][0]
    end
    def binfiles
    end
    def requires
      req = dependencies(@metadata.npmdata["dependencies"])
      req += dependencies(@metadata.npmdata["peerDependencies"])
      req.uniq
    end
    def build_requires
      dependencies @metadata.npmdata["devDependencies"]
    end

    def write
      begin
        Dir.mkdir @name
      rescue Errno::EEXIST
      end
      Dir.chdir @name

      url = @metadata.tarball
      puts "pulling #{url.inspect}"
      @local_source = Download.new(url).save.filename

      require 'erb'

      template_name = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "templates", "nodejs-opensuse.spec.erb"))
      template = File.read(template_name)
      # -:  omit blank lines ending in -%>
      erb = ERB.new(template, nil, "-")
      File.open("#{@name}.spec", "w+") do |f|
        spec = self
        f.puts erb.result
      end
    end
  end

end
