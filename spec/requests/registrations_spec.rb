require 'rails_helper'

RSpec.describe "Registrations", :type => :request do
  describe "GET /registrations" do
    it "works! (now write some real specs)" do
      get inscriptions_path
      expect(response.status).to be(200)
    end
  end
end
