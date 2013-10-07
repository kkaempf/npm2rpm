require 'openssl'
require 'open-uri'

class Download
  attr_reader :content
  # get url to local file, return local file name
  def initialize url
    puts "Download #{url.inspect}"
    @uri = URI.parse url
#    http = Net::HTTP.new @uri
#    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    @content = @uri.read :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE
  end
  def save
    File.open(self.filename, "w+") { |f| f.write @content }
    self
  end
  def filename
    @filename ||= File.basename(@uri.path)
  end
end

