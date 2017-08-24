require 'rails_helper'

RSpec.describe "TestAlternatives", type: :request do
  describe "GET /test_alternatives" do
    it "works! (now write some real specs)" do
      get test_alternatives_path
      expect(response).to have_http_status(200)
    end
  end
end
