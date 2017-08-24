require "rails_helper"

RSpec.describe TestAlternativesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/test_alternatives").to route_to("test_alternatives#index")
    end

    it "routes to #new" do
      expect(:get => "/test_alternatives/new").to route_to("test_alternatives#new")
    end

    it "routes to #show" do
      expect(:get => "/test_alternatives/1").to route_to("test_alternatives#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/test_alternatives/1/edit").to route_to("test_alternatives#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/test_alternatives").to route_to("test_alternatives#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/test_alternatives/1").to route_to("test_alternatives#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/test_alternatives/1").to route_to("test_alternatives#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/test_alternatives/1").to route_to("test_alternatives#destroy", :id => "1")
    end

  end
end
