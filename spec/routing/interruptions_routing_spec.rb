require "spec_helper"

describe InterruptionsController do
  describe "routing" do

    it "routes to #index" do
      get("/interruptions").should route_to("interruptions#index")
    end

    it "routes to #new" do
      get("/interruptions/new").should route_to("interruptions#new")
    end

    it "routes to #show" do
      get("/interruptions/1").should route_to("interruptions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/interruptions/1/edit").should route_to("interruptions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/interruptions").should route_to("interruptions#create")
    end

    it "routes to #update" do
      put("/interruptions/1").should route_to("interruptions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/interruptions/1").should route_to("interruptions#destroy", :id => "1")
    end

  end
end
