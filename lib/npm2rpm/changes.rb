module Npm2Rpm

  class Changes
    def initialize name, metadata, options
      @name = name
      @metadata = metadata
      @options = options
    end
    def message
      msg = "Initial version #{@metadata.pkgversion}"
      unless (@metadata.pkgversion == @metadata.srcversion)
        msg = msg + " (upstream #{@metadata.srcversion})"
      end
      msg
    end
    def write
      # create .changes file as
      # -------------------------------------------------------------------
      # Sat Oct  5 12:29:03 UTC 2013 - kkaempf@suse.com
      
      File.open("#{@name}.changes", "w+") do |f|
        f.puts "-------------------------------------------------------------------"
        f.puts "#{@options.date} - #{@options.email}@suse.com"
        f.puts
        f.puts "- #{self.message}"
      end
    end
  end

end
