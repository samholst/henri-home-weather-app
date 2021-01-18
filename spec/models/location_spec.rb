require 'rails_helper'

RSpec.describe Location, type: :model do
   it 'cannot be create without a zip' do
    expect { Location.create! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'it creates a saved location with a zip' do
    expect { Location.create!(zip: 85339) }.not_to raise_error(ActiveRecord::RecordInvalid)
  end 
end
