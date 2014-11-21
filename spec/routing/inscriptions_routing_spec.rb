require "rails_helper"

RSpec.describe InscriptionsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/inscriptions").to route_to("inscriptions#index")
    end

    it "routes to #new" do
      expect(:get => "/inscriptions/new").to route_to("inscriptions#new")
    end

    it "routes to #show" do
      expect(:get => "/inscriptions/1").to route_to("inscriptions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/inscriptions/1/edit").to route_to("inscriptions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/inscriptions").to route_to("inscriptions#create")
    end

    it "routes to #update" do
      expect(:put => "/inscriptions/1").to route_to("inscriptions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/inscriptions/1").to route_to("inscriptions#destroy", :id => "1")
    end

  end
end
