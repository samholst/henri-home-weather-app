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
      post :search, params: { zip: 85339 }

      expect(response).to have_http_status(:ok)
    end
  end
end
