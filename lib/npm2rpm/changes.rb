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

      f.puts <<EOF
-------------------------------------------------------------------
#{@options.date} - #{@options.email}@suse.com

- Initial version #{@metadata.version}
EOF
    end
  end
end
