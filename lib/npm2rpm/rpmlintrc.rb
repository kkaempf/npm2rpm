module Npm2Rpm

  class Rpmlintrc
    def initialize name, metadata, options
      @name = name
      @metadata = metadata
      @options = options
    end

    def write
      File.open("#{@name}-rpmlintrc", "w+") do |f|
        f.puts "addFilter(\"devel-file-in-non-devel-package .*\")"
        f.puts "addFilter(\"file-contains-buildroot .*\")"
        f.puts "addFilter(\"file-contains-date-and-time .*\")"
        f.puts "addFilter(\"hidden-file-or-dir .*\")"
        f.puts "addFilter(\"incorrect-fsf-address .*\")"
        f.puts "addFilter(\"non-executable-script .*\")"
        f.puts "addFilter(\"backup-file-in-package .*\")"        
        f.puts "addFilter(\"suse-filelist-forbidden-backup-file .*\")"        
        f.puts "addFilter(\"suse-filelist-forbidden .*\")"        
        f.puts "addFilter(\"summary-ended-with-dot .*\")"
#        f.puts "addFilter(\" .*\")"
      end
    end
  end

end
