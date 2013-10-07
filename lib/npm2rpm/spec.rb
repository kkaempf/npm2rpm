require 'erb'
class Spec
  attr_reader :name
  def initialize metadata
    @metadata = metadata
    @name = "nodejs-#{@metadata.name}_#{metadata.version}"
    puts "Package #{@name}"
  end

  def write
    begin
      Dir.mkdir @name
    rescue Errno::EEXIST
    end
    Dir.chdir @name

    File.open("#{@name}.spec", "w+") do |f|
      source = @metadata.download
      homepage = @metadata.homepage

      # Find out the top-level directory from tarball
      # The upstreams often use very weird ones
      toplevel = [`tar tzf #{source}` =~ /([^\/]+)/][0]

      # spec-write
    end
  end
end

