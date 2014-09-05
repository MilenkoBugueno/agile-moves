require 'rails_helper'

RSpec.describe "Certifications", :type => :request do
  describe "GET /certifications" do
    it "works! (now write some real specs)" do
      get certifications_path
      expect(response.status).to be(200)
    end
  end
end
