require 'rails_helper'

RSpec.describe "Media", :type => :request do
  describe "GET /media" do
    it "works! (now write some real specs)" do
      get media_path
      expect(response.status).to be(200)
    end
  end
end
