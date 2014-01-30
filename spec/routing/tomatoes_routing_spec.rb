require "spec_helper"

describe TomatoesController do
  describe "routing" do

    it "routes to #index" do
      get("/tomatoes").should route_to("tomatoes#index")
    end

    it "routes to #new" do
      get("/tomatoes/new").should route_to("tomatoes#new")
    end

    it "routes to #show" do
      get("/tomatoes/1").should route_to("tomatoes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tomatoes/1/edit").should route_to("tomatoes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tomatoes").should route_to("tomatoes#create")
    end

    it "routes to #update" do
      put("/tomatoes/1").should route_to("tomatoes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tomatoes/1").should route_to("tomatoes#destroy", :id => "1")
    end

  end
end
