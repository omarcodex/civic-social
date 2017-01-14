class WelcomeController < ApplicationController
  require 'net/http'
  require 'uri'

  def index

    # Setting up the cURL-like URL request (see https://propublica.github.io/congress-api-docs/#responses).

    uri = URI.parse("https://api.propublica.org/congress/v1/114/house/members.json")

    request = Net::HTTP::Get.new(uri)
    request["X-Api-Key"] = ENV['API_KEY']
    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    # Show the response in an appropriate form.
    render :json => response.body # <-- Nice way to debug.

    # @world = response.body
  end

end
