class HomeController < ApplicationController
  def index
  end

  def upload
    require 'net/http'
    require 'uri'
    uri = URI.parse('http://10.22.104.158:8080/videos/upload')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Put.new(uri.path, {'Content-Type' => 'video/*'})
    request.body = params[:video].read
    response = http.request(request)
    puts response
    redirect_to root_path
  end

end