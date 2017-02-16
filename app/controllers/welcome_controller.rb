class WelcomeController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def index

    # Setting up the cURL-like URL request (see https://propublica.github.io/congress-api-docs/#responses).
    @mapbox_token = ENV['MAPBOX_TOKEN']
    # twitter = twitter_client_setup
    # @user_tweets = twitter.user_timeline("sherlock_omz")
    render :index
  end

  private

  # def twitter_client_setup
  #   client = Twitter::REST::Client.new do |config|
  #     config.consumer_key        = ENV['TW_CONSUMER_KEY']
  #     config.consumer_secret     = ENV['TW_CONSUMER_SECRET']
  #     config.access_token        = ENV['TW_ACCESS_TOKEN']
  #     config.access_token_secret = ENV['TW_ACCESS_SECRET']
  #   end
  #
  #   return client
  # end

end
