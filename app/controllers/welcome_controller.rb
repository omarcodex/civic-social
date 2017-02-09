class WelcomeController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def index

    # Setting up the cURL-like URL request (see https://propublica.github.io/congress-api-docs/#responses).
    @mapbox_token = ENV['MAPBOX_TOKEN']
    render :index
  end

end
