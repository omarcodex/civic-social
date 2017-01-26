class BillsController < ApplicationController

  require 'net/http'
  require 'json'

  def index

    uri = URI.parse("https://api.propublica.org/congress/v1/115/senate/bills/introduced.json")

    request = Net::HTTP::Get.new(uri)
    request["X-Api-Key"] = ENV['API_KEY']
    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    raw_data = JSON.parse(response.body)

    recent_bills = raw_data["results"].first["bills"]

    @all_bills = []
    @bill = {}

    recent_bills.each do |hash|
      bill = {}
      bill[:number] = hash["number"]
      bill[:title] = hash["title"]
      bill[:link] = hash["bill_uri"]
      @all_bills << bill
     end

  render :index

  end

  def show

    @bill_id = params[:id]
    uri = URI.parse("https://api.propublica.org/congress/v1/115/bills/#{@bill_id}.json")

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

    render :show

  end


  def patch
  end

  def delete
  end

end



# {"number"=>"S.230", "bill_uri"=>"https://api.propublica.org/congress/v1/115/bills/s230.json", "title"=>"A bill to amend the Internal Revenue Code of 1986 to allow a credit against income tax for facilities using a qualified methane conversion technology to provide transportation fuels and chemicals.", "sponsor_uri"=>"https://api.propublica.org/congress/v1/members/C001075.json", "introduced_date"=>"January 24, 2017", "cosponsors"=>"0", "committees"=>"Senate Finance Committee", "primary_subject"=>"", "latest_major_action_date"=>"January 24, 2017", "latest_major_action"=>"Read twice and referred to the Committee on Finance."}
