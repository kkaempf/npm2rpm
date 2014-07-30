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
        when /^~?([\d\.]+)(-\d)?([a-z]+)?$/
          result << "npm(#{name}@#{$1})"
        # "^1.2.3"
        when /^\^([\d\.]+)(-\d)?([a-z]+)?$/
          result << "npm(#{name}@#{$1})"
        # "1.2.0-1.2.3"
        when /^([\d\.]+)-([\d\.]+)$/
          result << "npm(#{name}@#{$2})"
        # "1.2.x", "=0.7.x"
        when /^~?<?>?=?([^xY]+)(\.[xX])(.*)$/
          result << "npm(#{name}) > #{$1}"
        # ">= 1.0.0 < 1.2.0"
        when /^\>=?\s*([\d\.]+)(\s+\<\s*([\d\.]+))?$/
          result << "npm(#{name}) >= #{$1}"
          result << "npm(#{name}) < #{$3}" if $2
        # "*"
        # ""
        when "*", ""
          result << "npm(#{name})"
        when /\w+/
          result << "npm(#{name}@#{version})"
        else
          raise "Unrecognized dependency #{name.inspect}: #{version.inspect}"
        end
      end
      result
    end
    public
    def initialize metadata
      @metadata = metadata
      @name = "nodejs-#{@metadata.name}_#{@metadata.pkgversion}"
    end

    def npmname
      @metadata.name
    end
    def pkgversion
      @metadata.pkgversion
    end
    def srcversion
      @metadata.srcversion
    end
    def licenses
      if @metadata.licenses.nil?
        [ "Unknown" ]
      else
        @metadata.licenses.map do |l|
          l['type']
        end
      end
    end
    def summary
      @metadata.npmdata["description"]
    end
    def description
      @metadata.npmdata["description"]
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
      `tar tzf #{@local_source}` =~ /([^\/]+)/
      $1
    end
    def binfiles
      @metadata.npmdata["bin"]
    end
    # helper for provides
    def _provides version
      prv = Array.new
      v = version.split "."
      until v.empty? do
        prv << "npm(#{self.npmname}@#{v.join('.')})"
        v.pop
      end
      prv
    end
    def provides
      prv = Array.new
      prv << "npm(#{self.npmname}) = %{version}"
      minversion, maxversion = self.srcversion.split "-"
      if maxversion
        prv.concat( _provides maxversion )
      end
      prv.concat( _provides minversion ).uniq
    end
    def requires
      req = dependencies(@metadata.npmdata["dependencies"])
      req += dependencies(@metadata.npmdata["peerDependencies"])
      req
    end
    def build_requires
      dependencies @metadata.npmdata["devDependencies"]
    end

    def write
      url = @metadata.tarball
      @local_source = Download.new(url).save.filename

      require 'erb'

      template_name = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "templates", "nodejs-opensuse.spec.erb"))
      template = File.read(template_name)
      # -:  omit blank lines ending in -%>
      erb = ERB.new(template, nil, "-")
      File.open("#{@name}.spec", "w+") do |f|
        spec = self
        f.puts(erb.result(binding()))
      end
    end
  end

end
