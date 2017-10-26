class MembersController < ApplicationController

  require 'net/http'
  require 'json'

  def index

    raw_senate_members_data = JSON.parse(get_members_data_from_API(115,"senate").body)

    raw_house_members_data = JSON.parse(get_members_data_from_API(115,"house").body)

    senate_members = raw_senate_members_data["results"].first["members"]
    house_members = raw_house_members_data["results"].first["members"]

    @all_members = []
    @member = {}

    senate_members.each do |hash|
      member = {}
      member[:first_name] = hash["first_name"]
      member[:last_name] = hash["last_name"]
      member[:link] = hash["api_uri"]
      member[:party] = hash["party"]
      member[:state] = hash["state"]
      member[:next_election] = hash["next_election"]
      member[:twitter_account] = hash["twitter_account"]
      @all_members << member
     end

    house_members.each do |hash|
       member = {}
       member[:first_name] = hash["first_name"]
       member[:last_name] = hash["last_name"]
       member[:link] = hash["api_uri"]
       member[:party] = hash["party"]
       member[:state] = hash["state"]
       member[:next_election] = hash["next_election"]
       member[:twitter_account] = hash["twitter_account"]
       @all_members << member
    end

    @all_members.sort_by! { |member| member[:next_election].to_i }

  render :index

  end

  def show

    # Adding ProPubclica API data:

    @member_id = params[:id]
    uri = URI.parse("https://api.propublica.org/congress/v1/members/#{@member_id}.json")

    request = Net::HTTP::Get.new(uri)
    request["X-Api-Key"] = ENV['API_KEY']
    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    raw_data_all = JSON.parse(response.body)

    @raw_data_result_only = raw_data_all["results"].first

    # Adding Twitter API data:

    twitter = twitter_client_setup
    @user_tweets = twitter.user_timeline(@raw_data_result_only["twitter_account"])


    render :show

  end


  def patch
  end

  def delete
  end

  private

  def get_members_data_from_API(congress, chamber)

    uri = URI.parse("https://api.propublica.org/congress/v1/#{congress}/#{chamber}/members.json")

    request = Net::HTTP::Get.new(uri)
    request["X-Api-Key"] = ENV['API_KEY']
    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    return response

  end

  def twitter_client_setup
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TW_CONSUMER_KEY']
      config.consumer_secret     = ENV['TW_CONSUMER_SECRET']
      config.access_token        = ENV['TW_ACCESS_TOKEN']
      config.access_token_secret = ENV['TW_ACCESS_SECRET']
    end

    return client
  end

end
