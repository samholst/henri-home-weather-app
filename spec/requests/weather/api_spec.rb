RSpec.describe Weather::Api, type: :request do
  it 'can be instantiated with a zip' do
    expect { Weather::Api.new(85339) }.not_to raise_error(Exception)
  end

  it 'raises an expection without a zip' do
    expect { Weather::Api.new }.to raise_error(Exception)
  end

  it 'raises an expection if a zip is blank' do
    expect { Weather::Api.new("") }.to raise_error(Exception)
  end
end
