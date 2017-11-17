require 'rails_helper'

RSpec.describe "TestAnswers", type: :request do
  describe "GET /test_answers" do
    it "works! (now write some real specs)" do
      get test_answers_path
      expect(response).to have_http_status(200)
    end
  end
end
