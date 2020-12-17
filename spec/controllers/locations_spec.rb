require 'rails_helper'

RSpec.describe LocationsController do
  describe "create" do
    it "creates a location with a zip" do
      current_count = Location.count

      post :create, params: { zip: 85339 }

      expect(response).to have_http_status(:ok)
      expect(Location.count).not_to be current_count
    end

    it "does not create a location without a zip" do
      current_count = Location.count

      post :create

      expect(response).to have_http_status(:ok)
      expect(Location.count).to be current_count
    end
  end
end
