require 'spec_helper'

describe "Tomatoes" do
  describe "GET /tomatoes" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get tomatoes_path
      response.status.should be(200)
    end
  end
end
