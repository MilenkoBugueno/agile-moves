require "spec_helper"

describe MoveTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/move_types").should route_to("move_types#index")
    end

    it "routes to #new" do
      get("/move_types/new").should route_to("move_types#new")
    end

    it "routes to #show" do
      get("/move_types/1").should route_to("move_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/move_types/1/edit").should route_to("move_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/move_types").should route_to("move_types#create")
    end

    it "routes to #update" do
      put("/move_types/1").should route_to("move_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/move_types/1").should route_to("move_types#destroy", :id => "1")
    end

  end
end
