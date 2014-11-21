require 'rails_helper'

RSpec.describe "Inscriptions", :type => :request do
  describe "GET /inscriptions" do
    it "works! (now write some real specs)" do
      get inscriptions_path
      expect(response.status).to be(200)
    end
  end
end
