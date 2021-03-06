require "rails_helper"

RSpec.describe TestResponsesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/test_responses").to route_to("test_responses#index")
    end

    it "routes to #new" do
      expect(:get => "/test_responses/new").to route_to("test_responses#new")
    end

    it "routes to #show" do
      expect(:get => "/test_responses/1").to route_to("test_responses#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/test_responses/1/edit").to route_to("test_responses#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/test_responses").to route_to("test_responses#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/test_responses/1").to route_to("test_responses#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/test_responses/1").to route_to("test_responses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/test_responses/1").to route_to("test_responses#destroy", :id => "1")
    end

  end
end
