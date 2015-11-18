require 'net/http'
class ExternalConnection
    include ActiveModel::Serialization
    attr_reader :args
   def initialize(args={})
     args[:fecha_f] = Time.parse(args[:fecha_f]+"T23:59:00.000").to_i
     args[:fecha_i] = Time.parse(args[:fecha_i]+"T03:00:00.000").to_i
     args[:url] = (args[:url].include? "http://") ? args[:url] : "http://#{args[:url]}"
     @args = args
   end

  def send_data
    url = URI.parse("#{@args[:url]}/bus_id/#{@args[:bus_id]}/fecha_i/#{@args[:fecha_i]}/fecha_f/#{@args[:fecha_f]}")
    puts ""
    puts "url: #{url} "
    puts "url.host: #{url.host} "
    puts ""
    begin
      req = Net::HTTP::Get.new(url, initheader = {'Content-Type' =>'application/json'})
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      return res.body
    rescue TypeError => e
      puts "TypeError Catched: #{e}"
    end
    return 0
  end
end