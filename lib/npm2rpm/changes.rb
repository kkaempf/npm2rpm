module Npm2Rpm

  class Changes
    def initialize name, metadata, options
      @name = name
      @metadata = metadata
      @options = options
    end
    def write
      # create .changes file as
      # -------------------------------------------------------------------
      # Sat Oct  5 12:29:03 UTC 2013 - kkaempf@suse.com
      
      File.open("#{@name}.changes", "w+") do |f|
        f.puts "-------------------------------------------------------------------"
        f.puts "#{@options.date} - #{@options.email}@suse.com"
        f.puts
        if (@metadata.pkgversion == @metadata.srcversion)
          f.puts "- Initial version #{@metadata.pkgversion}"
        else
          f.puts "- Initial version #{@metadata.pkgversion} (upstream #{@metadata.srcversion})"
        end
      end
    end
  end

end
