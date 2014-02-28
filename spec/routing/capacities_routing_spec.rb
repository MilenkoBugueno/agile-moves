require "spec_helper"

describe CapacitiesController do
  describe "routing" do

    it "routes to #index" do
      get("/capacities").should route_to("capacities#index")
    end

    it "routes to #new" do
      get("/capacities/new").should route_to("capacities#new")
    end

    it "routes to #show" do
      get("/capacities/1").should route_to("capacities#show", :id => "1")
    end

    it "routes to #edit" do
      get("/capacities/1/edit").should route_to("capacities#edit", :id => "1")
    end

    it "routes to #create" do
      post("/capacities").should route_to("capacities#create")
    end

    it "routes to #update" do
      put("/capacities/1").should route_to("capacities#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/capacities/1").should route_to("capacities#destroy", :id => "1")
    end

  end
end
