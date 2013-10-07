#
# npm2rpm/lib/download.rb
#
# Implements http(s) download
#

require 'openssl'
require 'net/https'
require 'net/http'

module Npm2Rpm
  class Download
    attr_reader :content
    # get url to local file, return local file name
    def initialize url
      puts "Download #{url.inspect}"
      @uri = URI url
      http = Net::HTTP.new(@uri.host, @uri.port)
      if @uri.scheme == "https"
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        
        store = OpenSSL::X509::Store.new
        store.set_default_paths # Optional method that will auto-include the system CAs.
        crtpath = File.expand_path(File.join(File.dirname(__FILE__), "..", "registry.npmjs.org.crt"))                                           
        store.add_file(crtpath)
        http.cert_store = store
      end
      response = http.request(Net::HTTP::Get.new(@uri.request_uri))
      raise "#{url} failed with #{response.code}" unless response.code.to_i == 200
      @content = response.body
    end
    def save
      File.open(self.filename, "w+") { |f| f.write @content }
      self
    end
    def filename
      @filename ||= File.basename(@uri.path)
    end
  end
end
