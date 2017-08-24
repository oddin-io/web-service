require "rails_helper"

RSpec.describe TestQuestionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/test_questions").to route_to("test_questions#index")
    end

    it "routes to #new" do
      expect(:get => "/test_questions/new").to route_to("test_questions#new")
    end

    it "routes to #show" do
      expect(:get => "/test_questions/1").to route_to("test_questions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/test_questions/1/edit").to route_to("test_questions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/test_questions").to route_to("test_questions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/test_questions/1").to route_to("test_questions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/test_questions/1").to route_to("test_questions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/test_questions/1").to route_to("test_questions#destroy", :id => "1")
    end

  end
end
