require "rails_helper"

RSpec.describe CavesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/caves").to route_to("caves#index")
    end

    it "routes to #new" do
      expect(:get => "/caves/new").to route_to("caves#new")
    end

    it "routes to #show" do
      expect(:get => "/caves/1").to route_to("caves#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/caves/1/edit").to route_to("caves#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/caves").to route_to("caves#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/caves/1").to route_to("caves#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/caves/1").to route_to("caves#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/caves/1").to route_to("caves#destroy", :id => "1")
    end

  end
end
