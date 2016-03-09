require 'rails_helper'

RSpec.describe "Caves", type: :request do
  describe "GET /caves" do
    it "works! (now write some real specs)" do
      get caves_path
      expect(response).to have_http_status(200)
    end
  end
end
