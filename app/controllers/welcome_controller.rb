class WelcomeController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def index

    # Setting up the cURL-like URL request (see https://propublica.github.io/congress-api-docs/#responses).

    uri = URI.parse("https://api.propublica.org/congress/v1/115/house/members.json")

    request = Net::HTTP::Get.new(uri)
    request["X-Api-Key"] = ENV['API_KEY']
    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    # Omar's experimenting with bills extraction
    body = JSON.parse(response.body)
    bills = body["results"]

    # Show the response in an appropriate form.
    render :json => bills # <-- Nice way to debug.

    @world = bills
  end

end
