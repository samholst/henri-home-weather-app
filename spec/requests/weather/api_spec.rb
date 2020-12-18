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
end
