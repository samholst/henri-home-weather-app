RSpec.describe Weather::ZipForecast, type: :request do
  it 'can be instantiated with a forecast object and zip' do
    expect {
      Weather::ZipForecast.new(
        JSON.parse(File.open("#{Rails.root}/spec/mock_data/forecast_mock.json").read),
        85339
      )
    }.not_to raise_error(Exception)
  end

  it 'should have the correct attributes with mock data' do
    zip_forecast = Weather::ZipForecast.new(
        JSON.parse(File.open("#{Rails.root}/spec/mock_data/forecast_mock.json").read),
        85339
      )

    expect(zip_forecast.zip).to be(85339)
    expect(zip_forecast.high).to be(18.07)
    expect(zip_forecast.low).to be(8.52)
    expect(zip_forecast.average).to be(12.897916666666667)
    expect(zip_forecast.current_temp).to be(14.22)
    expect(zip_forecast.hourly_forecasts).to eq(JSON.parse(File.open("#{Rails.root}/spec/mock_data/hourly_forecasts.json").read))
  end
end
