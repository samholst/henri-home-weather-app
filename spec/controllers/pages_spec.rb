require 'rails_helper'

RSpec.describe PagesController do
  describe "home" do
    it "can access the home page" do
      get :home

      expect(response).to have_http_status(:ok)
    end
  end

  describe "search" do
    it "can search for a forecast by zip code" do
      stub_request(:get, "#{Weather::Api::BASE_URL}#{Weather::Api::ZIP_ENDPOINT}?APPID=#{Weather::Api::APP_ID}&zip=85339").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.openweathermap.org', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => File.open("#{Rails.root}/spec/mock_data/zip_mock.json"), :headers => {})

      stub_request(:get, "#{Weather::Api::BASE_URL}#{Weather::Api::FORECAST_ENDPOINT}?APPID=#{Weather::Api::APP_ID}&lat=33.34&lon=-112.17&units=metric").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.openweathermap.org', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => File.open("#{Rails.root}/spec/mock_data/forecast_mock.json"), :headers => {})

      post :search, params: { zip: 85339 }

      expect(response).to have_http_status(:ok)
    end
  end
end
