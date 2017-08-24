require 'rails_helper'

RSpec.describe "TestQuestions", type: :request do
  describe "GET /test_questions" do
    it "works! (now write some real specs)" do
      get test_questions_path
      expect(response).to have_http_status(200)
    end
  end
end
