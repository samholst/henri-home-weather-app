RSpec.describe Weather::API, type: :request do
  it 'can be instantiated with a zip' do
    expect { Weather::API.new(85339) }.not_to raise_error(Exception)
  end

  it 'raises an expection without a zip' do
    expect { Weather::API.new }.to raise_error(Exception)
  end

  it 'raises an expection if a zip is blank' do
    expect { Weather::API.new("") }.to raise_error(Exception)
  end

  it 'should have an assigned zip' do
    weather_api = Weather::API.new(85339)

    expect(weather_api.instance_variable_get(:@zip)).to be(85339)
  end

  it 'should return nil for a bad request for zip endpoint' do
    stub_request(:get, "#{Weather::API::BASE_URL}#{Weather::API::ZIP_ENDPOINT}?APPID=#{Weather::API::APP_ID}&zip=85339").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.openweathermap.org', 'User-Agent'=>'Ruby'}).
      to_return(:status => 400, :body => "", :headers => {})

    weather_api = Weather::API.new(85339)

    expect(weather_api.get_result).to be(nil)
  end

  it 'should return nil for a bad request for forecast endpoint' do
    stub_request(:get, "#{Weather::API::BASE_URL}#{Weather::API::ZIP_ENDPOINT}?APPID=#{Weather::API::APP_ID}&zip=85339").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.openweathermap.org', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => File.open("#{Rails.root}/spec/mock_data/zip_mock.json"), :headers => {})

    stub_request(:get, "#{Weather::API::BASE_URL}#{Weather::API::FORECAST_ENDPOINT}?APPID=#{Weather::API::APP_ID}&lat=33.34&lon=-112.17&units=metric").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.openweathermap.org', 'User-Agent'=>'Ruby'}).
      to_return(:status => 400, :body => "", :headers => {})

    weather_api = Weather::API.new(85339)

    expect(weather_api.get_result).to be(nil)
  end
end
